Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Vincent Katz <vincent.katz@laposte.net>,
	jhartmann@precisioninsight.com
Subject: Re: AGP : ATI128,powerpc
Date: Wed, 14 Nov 2001 16:09:44 -0500
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org,
	paulus@au.ibm.com
References: <1005771164.6732.19.camel@avalon>
In-Reply-To: <1005771164.6732.19.camel@avalon>
MIME-Version: 1.0
Message-Id: <20011114210702.ELOS11133.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Try Ben Herrenschmidt's tree.  There is support for powerpc in that tree.

Kevin

On November 14, 2001 03:52, Vincent Katz wrote:
> Hi,
>
> Linux version : 2.4.14
> File with a supposed probleme : linux/drivers/char/agp/agpgart_be.c
>
> I have a powerpc with an ati128 AGP.
>
> When i compile the kernel i have this error : error "Please define
> flush_cache."
>
> this error come from the function flush_cache in agpgart_be.c where
> definition for powerpc are not setting . Why ?
>
> > static inline void flush_cache(void)
> >{
> >#if defined(__i386__) || defined(__x86_64__)
> >        asm volatile ("wbinvd":::"memory");
> >#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__)
> >        /* ??? I wonder if we'll really need to flush caches, or if the
> >           core logic can manage to keep the system coherent.  The ARM
> >           speaks only of using `cflush' to get things in memory in
> >           preparation for power failure.
> >
> >           If we do need to call `cflush', we'll need a target page,
> >           as we can only flush one page at a time.
> >
> >           Ditto for IA-64. --davidm 00/08/07 */
> >        mb();
> >#else
> >#error "Please define flush_cache."
> >#endif
> >}
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
