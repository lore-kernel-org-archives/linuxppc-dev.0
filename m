Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id D50C0B7C3D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 10:56:15 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 9 Nov 2009 11:10:42 -0700
Subject: Invalidate Data Cache from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310AFEC3@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I have a routine to invalidate the data cache from user space (since I do n=
ot believe there is a standard routine I can use outside of kernel space??)=
.

Here is the code:

	.text;
	.globl cacheInvalidate405;
cacheInvalidate405:

      /*
       *   r3 =3D Data cache
       *   r4 =3D address
       *   r5 =3D number of bytes
       */

        cmpwi   r5,0                /* make sure number of bytes is > 0 */
        beq     invalDone
        add     r6,r4,r5
        addi    r6,r6,31
        rlwinm  r6,r6,0,0,26        /* end addr to start of next cache line=
 */
        rlwinm  r7,r4,0,0,26        /* start address back to start of line =
 */
        sub     r6,r6,r7
        srawi   r6,r6,5             /* divide by 32 to get number of lines =
 */
        mtctr   r6
invalLoop:
        dcbi    r0,r4			/* THIS INSTRUCTION FAILS! */
        addi    r4,r4,32
        bdnz    invalLoop
        sync
invalDone:
        blr
.size	cacheInvalidate405, . - cacheInvalidate405

What is happening is the dcbi instruction will fail.  I get an Illegal Inst=
ruction message on the console and my program exits.

Is there a reason I cannot call dbci from a user space application, or is t=
here something wrong in my code?  Even better, is there a working and teste=
d function that I can call from user space to invalidate a portion of the d=
ata cache?

Thanks!

Jonathan
