Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: gopi@india.tejasnetworks.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unable to write to SIMASK
Date: Wed, 20 Feb 2002 18:27:52 -0300
References: <Pine.LNX.4.21.0202210030560.24106-100000@tn100build.india.tejasnetworks.com>
In-Reply-To: <Pine.LNX.4.21.0202210030560.24106-100000@tn100build.india.tejasnetworks.com>
MIME-Version: 1.0
Message-Id: <02022018275201.01017@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 20 February 2002 21:53, gopi@india.tejasnetworks.com wrote:
> hi..
>
>   We have an MPC860T based custom board.
>
>   We wanted to control interrupt on one of the irqs by writing to SIMASK
> register using a small driver with two ioctls which will will do
> the following:
>
>   // WRITE_MASK_IOCTL
>   simask_write_ioctl(mask) {
>     cli();
better use save_flags(flags); cli();

>     (volatile unsigned int *)(IMMR + simask_offset) = mask;
You're missing a * operator here (don't know about your actual source code,
though...)

>     written_value = *(volatile unsigned int *)(IMMR + simask_offset);
>     sti();
better use restore_flags(flags)... and flags must be defined as an unsigned
long.

>     printk (written_value);
>   }
>
>   // READ_MASK_IOCTL
>   simask_read_ioctl() {
>     cli(); // Not really needed..
>     read_value = *(volatile unsigned int *)(IMMR + simask_offset);
>     sti();
>     printk (read_value);
>   }
>
>
<snip>


HTH,

R. Scop


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
