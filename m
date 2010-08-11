Return-Path: <piotr@hosowicz.com>
Received: from 27.mail-out.ovh.net (27.mail-out.ovh.net [91.121.30.210])
	by ozlabs.org (Postfix) with SMTP id 7303CB70A9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 19:05:50 +1000 (EST)
Message-ID: <4C626659.5040704@example.com>
Date: Wed, 11 Aug 2010 10:59:05 +0200
From: Piotr Hosowicz <piotr@hosowicz.com>
MIME-Version: 1.0
To: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: kernel version 2.6.35-git10 build failure
References: <4C624F7F.3070608@linux.vnet.ibm.com>
	<20100811132313.3d6c7f27@sripathi.in.ibm.com>
In-Reply-To: <20100811132313.3d6c7f27@sripathi.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, divya <dipraksh@linux.vnet.ibm.com>
Reply-To: piotr@hosowicz.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11.08.2010 09:53, Sripathi Kodi wrote:
> On Wed, 11 Aug 2010 12:51:35 +0530
> divya<dipraksh@linux.vnet.ibm.com>  wrote:
>
>> Hi,
>>
>> Today kernel(version 2.6.35-git10 -commitid 3d30701b58970) build fails with following error on both system x and p
>>
>>     fs/9p/vfs_inode.c: In function 'v9fs_vfs_setattr_dotl':
>>     fs/9p/vfs_inode.c:1267: error: implicit declaration of function 'inode_setattr'
>>     make[2]: *** [fs/9p/vfs_inode.o] Error 1
>>     make[2]: *** Waiting for unfinished jobs....
>>     make[1]: *** [fs/9p] Error 2
>>     make[1]: *** Waiting for unfinished jobs....
>>     make: *** [fs] Error 2
>>     make: *** Waiting for unfinished jobs....
>>
>> Seems like the commit 87d7845aa0b is the corrupt which added the function v9fs_vfs_setattr_dotl()
>
> Yes, it is a problem I created. Stephen Rothwell has already fixed it.
> Al Viro has sent a git pull request to Linus today with the fix in it.
> Here is the patch you need: http://lkml.org/lkml/2010/6/21/442

I fail to apply the patch.

aapi205:/usr/src/linux# patch -p1 < ../9p-patch.txt
patching file fs/9p/vfs_inode.c
Hunk #1 FAILED at 1052.
1 out of 1 hunk FAILED -- saving rejects to file fs/9p/vfs_inode.c.rej

aapi205:/usr/src/linux# cat fs/9p/vfs_inode.c.rej
--- fs/9p/vfs_inode.c
+++ fs/9p/vfs_inode.c
@@ -1052,10 +1052,19 @@
                 return PTR_ERR(fid);

         retval = p9_client_setattr(fid, &p9attr);
-       if (retval >= 0)
-               retval = inode_setattr(dentry->d_inode, iattr);
+       if (retval < 0)
+               return retval;

-       return retval;
+       if ((iattr->ia_valid & ATTR_SIZE) &&
+           iattr->ia_size != i_size_read(dentry->d_inode)) {
+               retval = vmtruncate(dentry->d_inode, iattr->ia_size);
+               if (retval)
+                       return retval;
+       }
+
+       setattr_copy(dentry->d_inode, iattr);
+       mark_inode_dirty(dentry->d_inode);
+       return 0;
  }

  /**

I must be doing something wrong way.

Regards,

Piotr Hosowicz

-- 
Z cyklu "Uroki demokracji", czyli pytania i odpowiedzi w teledurniejach:
- Jak± walutê maj± Indie?
- Ramadan.
NP: Patrick O'Hearn - Approaching Summit
NB: 2.6.35-git9
