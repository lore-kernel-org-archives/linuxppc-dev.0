Subject: Re: File size!!!
To: shalijain@rediffmail.com (shalini jain)
Date: Sun, 18 Mar 2001 10:08:19 -0800 (PST)
Cc: linuxppc-dev@lists.linuxppc.org (linuxppc-dev@lists.linuxppc.org)
In-Reply-To: <20010317205140.31029.qmail@mailweb20.rediffmail.com> from "shalini  jain" at Mar 17, 2001 08:51:40 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20010318180819.42C6C2B54B@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


shalini  jain wrote:
> can someone suggest the way to find the file size in ext2fs ? actually, want to find the file size in bytes,i.e, the true file size and not in terms of the blocks allocated to the file.

In the kernel:

inode->i_size

In a regular application ( in C ):

#include <sys/stat.h>
#include <unistd.h>

off_t getfilesize(char *myfile)
{
	struct stat fileinfo;
	int err;

	err = stat(myfile, &fileinfo);
	if(err == -1) {
		/* Do something about the error */
		return 0;
	}
	return fileinfo.st_size;
}

> is there any EOF char in ext2fs files ? if yes. what is it ? is there any other way of knowing the file size than to count  up to EOF ???

No.

The file size is kept in filesystem metadata, not in the file.

(Every sane filesystem handles file size this way. Even HFS/HFS+)

	Brad Boyer
	flar@pants.nu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
