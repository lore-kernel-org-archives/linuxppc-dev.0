Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis <hollis-lists@austin.rr.com>
To: Samuel Rydh <samuel@ibrium.se>
Subject: Re: Modules and CONFIG_ALTIVEC
Date: Sun, 5 Aug 2001 18:08:21 -0500
References: <20010805234945.A837@ibrium.se>
In-Reply-To: <20010805234945.A837@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <01080518082100.00490@silence.internal>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday 05 August 2001 04:49, Samuel Rydh wrote:
> On ppc, the size of thread_struct depends on the CONFIG_ALTIVEC setting.
> Thus, the offset of various task_struct fields are dependent upon this
> config option.
[snip]
>         unsigned long   fpscr;          /* Floating point status */
> -#ifdef CONFIG_ALTIVEC
> -       vector128       vr[32];         /* Complete AltiVec set */
> -       vector128       vscr;           /* AltiVec status */
> -       unsigned long   vrsave;
> -#endif /* CONFIG_ALTIVEC */
> +	altivec_t	*vregs;

This also affects gdb. When gdb reads a core file, it gets upset if the size
of a regset isn't what it thinks it should be. Currently it's a bit too easy
to change that size...

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
