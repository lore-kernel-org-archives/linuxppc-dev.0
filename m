Date: Tue, 12 Nov 2002 10:56:17 +0100 (MET)
Message-Id: <200211120956.gAC9uHG14591@hzsc257.nl.lucent.com>
To: linuxppc-embedded@lists.linuxppc.org,
	joakim.tjernlund@lumentis.se
Subject: Re: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
From: Jaap-Jan Boor <jjboor@lucent.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim,

Enable loop unrolling by default for 8xx processors is not
a good idea because of the limited instructions cache size.

I think that's also what is recommended in the ppc faq: enable
size optimization (-Os) for 8xx processors gives better performance.

For a 750 or so, it would be good to enable loop unrolling.

Jaap-Jan


>
> Hi
>
> I optimized the crc32() in JFFS2(fs/jffs2/crc.h) by manually unrolling
> the crc32 loop. This gave me a speed increase of 22% in mounting JFFS2 FS
>
> Later Alan Cox pointed out that my changes makes x86 run slower and it turns
> out that on x86 and a fairly new gcc will automatically unroll loops 'where appropriate'
>
> Removed my hand coded unrolling and added -funroll-loops to the JFFS2 Makefile,
> I got similar results as my hand coded unrolling (a little better).
>
> I therefore conclude that ppc_8xx-gcc 2.95.3 from Monta Vista does not do ANY unrolling
> unless you specify -funroll-loops. Doing this for the whole kernel is NOT a good idea,
> it will run slower due to big increase of size.
>
> Now I wonder:
> Is this a gcc 2.95.3, PPC or Monta Vista limitation?
>
> Which compiler will do unrolling 'where appropriate' for 8xx PPC and
> Where can I get a precompiled version?
>
> The short term solution is to specify -funroll-loops for individual files/directories.
> Obviously JFFS2 should be included, but what else?
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
