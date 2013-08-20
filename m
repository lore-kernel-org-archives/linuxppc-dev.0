Return-Path: <dwight.engen@oracle.com>
Date: Tue, 20 Aug 2013 12:07:02 -0400
From: Dwight Engen <dwight.engen@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree
Message-ID: <20130820120702.000b044e@oracle.com>
In-Reply-To: <20130820172052.1f0d89ddf6a1a40ef70333fd@canb.auug.org.au>
References: <20130820172052.1f0d89ddf6a1a40ef70333fd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 David Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 xfs@oss.sgi.com, Ben Myers <bpm@sgi.com>, linux-next@vger.kernel.org,
 Gao feng <gaofeng@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Aug 2013 17:20:52 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> arch/powerpc/platforms/cell/spufs/inode.c: In function
> 'spufs_parse_options':
> arch/powerpc/platforms/cell/spufs/inode.c:623:16: error: incompatible
> types when assigning to type 'kuid_t' from type 'int' root->i_uid =
> option; ^ arch/powerpc/platforms/cell/spufs/inode.c:628:16: error:
> incompatible types when assigning to type 'kgid_t' from type 'int'
> root->i_gid = option; ^
> 
> Caused by commit d6970d4b726c ("enable building user namespace with
> xfs") from the xfs tree (that was fun to find :-)).
> 
> I have reverted that commit for today.  It could probably be replaced
> with a patch that just changed XFS_FS to SPU_FS in the
> UIDGID_CONVERTED config dependency - or someone could fix up SPU_FS.

Hi, (already sent this email based on Intel's kbuild robot this
morning, sorry for the dup to those who already got it). 

Yep this looks to me like SPU_FS should have been in the list of
stuff that had not been UIDGID_CONVERTED, but reviving
UIDGID_CONVERTED and adding SPU_FS to it won't work for
non powerpc arch because SPU_FS = n won't be defined. The following can
be used to mark it as incompatible with USER_NS:

diff --git a/arch/powerpc/platforms/cell/Kconfig
b/arch/powerpc/platforms/cell/Kconfig index 9978f59..fcf8336 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -61,6 +61,7 @@ config SPU_FS
        tristate "SPU file system"
        default m
        depends on PPC_CELL
+       depends on USER_NS=n
        select SPU_BASE
        select MEMORY_HOTPLUG
        help

Or if the rest of spufs is already okay for user namespace (I have not
checked it, but this seems to be the only place it is dealing with
uid/gid), then the following will fix these particular errors
(cross-compile tested, but I don't have a powerpc to run test on):

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index f390042..90fb308 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -620,12 +620,12 @@ spufs_parse_options(struct super_block *sb, char *options, struct inode *root)
                case Opt_uid:
                        if (match_int(&args[0], &option))
                                return 0;
-                       root->i_uid = option;
+                       root->i_uid = make_kuid(&init_user_ns, option);
                        break;
                case Opt_gid:
                        if (match_int(&args[0], &option))
                                return 0;
-                       root->i_gid = option;
+                       root->i_gid = make_kgid(&init_user_ns, option);
                        break;
                case Opt_mode:
                        if (match_octal(&args[0], &option))
