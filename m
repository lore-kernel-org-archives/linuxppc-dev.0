Message-Id: <v04003a07b31cd38ecda9@[10.0.0.2]>
In-Reply-To: <4.2.0.25.19990322190038.03b07d60@mail.lauterbach.com>
References: <v04003a00b31ae22dc5ae@[10.0.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 23 Mar 1999 00:17:52 -0500
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
From: Paul Barrette <barretp@mcmail.cis.mcmaster.ca>
Subject: Re: VRAM not recognized! platinumfb, kernel 2.2.2
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you Franz, the "dcbf" substitution for "dcbi" worked like a charm.
That is much better than forcing it to recognize x amount of ram, what if I
buy more vram, another compile? -it is not necessary now, good call.

>At 19:08 21.03.99 , Paul Barrette wrote:
>>It was suggested that I hack the video driver to force it to use 2mb for
>>vram (platinumfb.c file?).  Here is where I would guess to set it:
>>bank0 = 1; /* builtin 1MB vram, always there */
>>bank1 = info->base_frame_buffer[0x100000] == 0x34;
>>
>>****can I just set "bank1=1;" and get away with it?  Or does the kernel
>>have to find it?
>
>yes, you can simply set bank1=1. But as I modified this code a while ago to
>fix this, I would like you to try some things:
>
>- does it work if you replace the "dcbi" assembler instruction a few lines
>before in the invalidate_cache() macro with "dcbf"?
>- or if you add a 2nd eieio after dcbi/dcbf?
>
>BTW, which compiler version are you using?
>
>Franz.
>


--
Paul Barrette
Ph.D. candidate, dept. of Classics
System Administrator
McMaster University

umbra loco deerat; qua postquam parte resedit
Dis genitus vates et fila sonantia movit,
umbra loco venit.                  (Ov. Met. 10. 88 ff.)
http://www.humanities.mcmaster.ca/~barrette/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
