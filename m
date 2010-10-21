Return-Path: <knikanth@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 9455BB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 23:02:19 +1100 (EST)
From: Nikanth Karthikesan <knikanth@suse.de>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/9] v3 De-couple sysfs memory directories from memory
	sections
Date: Thu, 21 Oct 2010 17:35:19 +0530
References: <4CA62700.7010809@austin.ibm.com>
In-Reply-To: <4CA62700.7010809@austin.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010211735.19276.knikanth@suse.de>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 October 2010 23:52:56 Nathan Fontenot wrote:
> This set of patches decouples the concept that a single memory
> section corresponds to a single directory in
> /sys/devices/system/memory/.  On systems
> with large amounts of memory (1+ TB) there are performance issues
> related to creating the large number of sysfs directories.  For
> a powerpc machine with 1 TB of memory we are creating 63,000+
> directories.  This is resulting in boot times of around 45-50
> minutes for systems with 1 TB of memory and 8 hours for systems
> with 2 TB of memory.  With this patch set applied I am now seeing
> boot times of 5 minutes or less.
> 
> The root of this issue is in sysfs directory creation. Every time
> a directory is created a string compare is done against all sibling
> directories to ensure we do not create duplicates.  The list of
> directory nodes in sysfs is kept as an unsorted list which results
> in this being an exponentially longer operation as the number of
> directories are created.
> 

Can we simply remove this check for this case alone?! :)

Thanks
Nikanth

Do not check for an entry with the same name is already present, when
__sysfs_add_one() is directly called, bypassing sysfs_add_one().

Currently register_mem_sect_under_node() calls
sysfs_create_link_nowarn(), which is the only caller to do so.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

---

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 7e54bac..14d965c 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -368,21 +368,16 @@ void sysfs_addrm_start(struct sysfs_addrm_cxt *acxt,
  *	This function should be called between calls to
  *	sysfs_addrm_start() and sysfs_addrm_finish() and should be
  *	passed the same @acxt as passed to sysfs_addrm_start().
+ *	And there should be no sibling with the same name.
  *
  *	LOCKING:
  *	Determined by sysfs_addrm_start().
  *
- *	RETURNS:
- *	0 on success, -EEXIST if entry with the given name already
- *	exists.
  */
-int __sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
+void __sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
 {
 	struct sysfs_inode_attrs *ps_iattr;
 
-	if (sysfs_find_dirent(acxt->parent_sd, sd->s_ns, sd->s_name))
-		return -EEXIST;
-
 	sd->s_parent = sysfs_get(acxt->parent_sd);
 
 	sysfs_link_sibling(sd);
@@ -394,7 +389,6 @@ int __sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
 		ps_iattrs->ia_ctime = ps_iattrs->ia_mtime = CURRENT_TIME;
 	}
 
-	return 0;
 }
 
 /**
@@ -439,10 +433,9 @@ static char *sysfs_pathname(struct sysfs_dirent *sd, char *path)
  */
 int sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
 {
-	int ret;
+	int ret = 0;
 
-	ret = __sysfs_add_one(acxt, sd);
-	if (ret == -EEXIST) {
+	if (sysfs_find_dirent(acxt->parent_sd, sd->s_ns, sd->s_name)) {
 		char *path = kzalloc(PATH_MAX, GFP_KERNEL);
 		WARN(1, KERN_WARNING
 		     "sysfs: cannot create duplicate filename '%s'\n",
@@ -450,8 +443,11 @@ int sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
 		     strcat(strcat(sysfs_pathname(acxt->parent_sd, path), "/"),
 		            sd->s_name));
 		kfree(path);
+		ret = -EEXIST;
 	}
 
+	__sysfs_add_one(acxt, sd);
+
 	return ret;
 }
 
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index a7ac78f..7c56d34 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -72,7 +72,7 @@ static int sysfs_do_create_link(struct kobject *kobj, struct kobject *target,
 		if (warn)
 			error = sysfs_add_one(&acxt, sd);
 		else
-			error = __sysfs_add_one(&acxt, sd);
+			__sysfs_add_one(&acxt, sd);
 	} else {
 		error = -EINVAL;
 		WARN(1, KERN_WARNING
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index d9be60a..35449c8 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -155,7 +155,7 @@ struct sysfs_dirent *sysfs_get_active(struct sysfs_dirent *sd);
 void sysfs_put_active(struct sysfs_dirent *sd);
 void sysfs_addrm_start(struct sysfs_addrm_cxt *acxt,
 		       struct sysfs_dirent *parent_sd);
-int __sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd);
+void __sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd);
 int sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd);
 void sysfs_remove_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd);
 void sysfs_addrm_finish(struct sysfs_addrm_cxt *acxt);
