To: C.Gillan@ecit.qub.ac.uk
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Jun 2004 12:13:02 BST."
             <34753.143.117.36.139.1088161982.squirrel@143.117.36.139>
Date: Fri, 25 Jun 2004 14:57:01 +0200
Message-Id: <20040625125706.5F625C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <34753.143.117.36.139.1088161982.squirrel@143.117.36.139> you wrote:
>
> I would like to to be able to build only one binary file
> to be used for download to the target, rather than have to
> download the kernel and filesystem separately. But, I'm not sure if
> this is possible and if it is, how to set up the bootm command
> to work with this. Perhaps, I've missed something in the documentation.

Yes, you missed the section "More About U-Boot Image  Types"  in  the
README  which  explains what "Multi-File Images" are and how they can
be used to do exactly what you are looking for, and you  also  missed
to    read    the    FAQ    section    in    the   DULG,   especially
http://www.denx.de/twiki/bin/view/DULG/CombiningKernelAndRamdisk

> As I understand it, the mkimage utility that comes with the PPCBoot/Das
> U-Boot bootloader software can build a combined image containing both
> the kernel and the file system - following is from the PPCBoot documentation:
>
>  -> tools/mkimage -n '2.2.13 for initrd on TQM850L' \
>         > -A ppc -O linux -T kernel -C gzip -a 00000000 -e 0000000C \
>         > -d /opt/mpc8xx/src/linux-2.2.13/arch/ppc/coffboot/vmlinux.gz \
>         > examples/image-2.2.13-initrd

Well, "-T kernel" requests for a "kernel type"  image.  If  you  want
something  else, use a different option (like -T multi" for multifile
images. See mkimage's useage message.

> My confusion arises from the fact that I don't see a way of
> specifying the address to which the file system will be downloaded,

You don;t have to care. U-Boot will do this automagically.

> As I understand it, I need to specify that address as the second
> argument on the bootm command, e.g.
>
>     bootm <kernel-address> <file-system-address>

This is just for separate images. With a multifile  image,  ther  eis
only one image and thus only one address argument for 'bootm'.

> I'd be grateful for any help received.

Chances for help would be better if you didn't post to  mailing  list
where  your  question  is off topic - this has actually nothing to do
with  linuxppc-embedded;  you  should  have  posted  to  u-boot-users
instead.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Time is a drug. Too much of it kills you.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
