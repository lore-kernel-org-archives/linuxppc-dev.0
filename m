Date: Wed, 5 Nov 2003 10:47:13 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQS on 6 Slot Macs
In-Reply-To: <a04310101bbce0854283b@[199.170.89.118]>
Message-ID: <Pine.GSO.4.21.0311051041500.3572-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Nov 2003, Jeff Walther wrote:
> At 09:32 +1100 11/05/2003, Benjamin Herrenschmidt wrote:
> >Isn't MESH an IBM part ? I may be confused... Also, I would have
> >expected MESH to be actually _inside_ GC, it isn't ?
>
> It is an Apple part.  I do not know for certain where it came from
> originally.  However, following the evolution of Apple design
> suggests that it's based on the NCR 53CF96.   The previous generation
> of machines, the PPC NuBus machines, included the PMac 8100 and 9100
> which used exactly the same CURIO chip as the x500 machines to
> provide the slow (5 MB/s) ethernet and used the NCR 53CF96 to provide
> the Fast SCSI bus.   Earlier machines (the Quadras) used the NCR
> 53C96 to handle their SCSI bus.   And, of course, the earlier
> machines used the NCR 53C80.
>
> Additionally, the 53CF96 chip in the 8100 is in a 100 pin, 20 X 30
> quad flat pack.   MESH is in exactly the same package.    This is not
> definitive, but suggests to me that MESH is simply a licensed 53CF96.
>
>
> MESH is a separate chip and is not contained in GC.   It would be
> kind of cool if MESH was in GC, because then one could implement the
> Fast SCSI bus on 7200s and the PCC Catalyst clones, but that's not
> the way it is....
>
> In my queue of projects (massive and ever lengthening) is to install
> a 53CF96 in place of a MESH and/or vice versa and see what happens.
> However, I wonder if a similar test could be done with software.   I
> assume that Linux implements some kind of driver to support MESH.
> Is there a driver for the 53CF96 which could be substituted or
> compared as an experiment.

There's a driver for the 53C96 in the Quadra (mac_esp.c and NCR53C9x.c).

The NCR53C9x.c core supports various 53C9x chips, including (53CF9x and FAS*),
and is used on various platforms.  It's very similar to the esp.c core for
SPARC, but Dave didn't like us to merge non-SPARC support in his driver.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
