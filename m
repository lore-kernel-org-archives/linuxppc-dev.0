Message-ID: <3C8F922A.8090201@cambridgebroadband.com>
Date: Wed, 13 Mar 2002 17:53:46 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Formatting JFFS2 Flash
References: <A1C99F4731CAD111BA5400A024FC3B0CBE0414@ESBILMA01EDCGE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Question:

Did you initialise the FS with

cat jffs2.image > /dev/mtd0

before you tried to mount /mtdblock0 ?

If you did not, then kernel threads will indeed start formatting the FS after you mount it.

2nd question:

Did you use an empty directory with mkfs.jffs2 to make your jffs2.image?  This doesn't work - you
end up with a 0 length jffs2.image!  If this was the case then even if you did initialise the FS
with "cat jffs2.image > /dev/mtd0" you will still find the kernel threads format the FS after you
mount it.

I think this is a bug - the workaround is to use a non-empty folder to make your jffs2.image from.

Alex

Billalabeitia, Jose Carlos (IndSys, GEPM) wrote:

> Hi:
>
> 	I have a PPC 860T custom board with kernel
> 2.4.4-2001-11-11-denx and rtai-24.1.4-2-denx. I have
> a JFFS2 filesystem on 14MB Flash. I make an initial
> filesystem with the "mkfs.jffs2" utility, and the first time
> I copy a 1MB file into it, it takes about 2 minutes, and
> then on it takes 10 seconds to copy into it the same file.
> I suppose that the first time, jffs2 is doing something like
> "formatting" the flash.
> Does anybody out there know how to do this "formatting"
> in a smarter way?
>
> 				Thank you
> 					Billa
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
