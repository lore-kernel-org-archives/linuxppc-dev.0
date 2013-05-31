Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99BBE2C02C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:58:57 +1000 (EST)
Message-ID: <1370001530.5199.118.camel@zakaz.uk.xensource.com>
Subject: Re: DTB build failure due to preproccessing
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 31 May 2013 12:58:50 +0100
In-Reply-To: <20130531114824.60D223E0901@localhost>
References: <1369996170.5199.68.camel@zakaz.uk.xensource.com>
 <20130531114824.60D223E0901@localhost>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, JonLoeliger <jdl@jdl.com>, Stephen
 Warren <swarren@nvidia.com>, linux-kbuild@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-31 at 12:48 +0100, Grant Likely wrote:
> On Fri, 31 May 2013 11:29:30 +0100, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> > This affects arch/powerpc/boot/dts/virtex440-ml510.dts but I think it is
> > actually a more general issue:
> > 
> >         $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux- virtex440-ml510.dtb 
> >           CC      scripts/mod/devicetable-offsets.s
> >           GEN     scripts/mod/devicetable-offsets.h
> >           HOSTCC  scripts/mod/file2alias.o
> >           HOSTLD  scripts/mod/modpost
> >           DTC     arch/powerpc/boot/virtex440-ml510.dtb
> >         Error: arch/powerpc/boot/dts/virtex440-ml510.dts:374.6-7 syntax error
> >         FATAL ERROR: Unable to parse input tree
> >         make[1]: *** [arch/powerpc/boot/virtex440-ml510.dtb] Error 1
> >         make: *** [virtex440-ml510.dtb] Error 2
> >         
> > Line 374 is the "IDSEL 0x16..." line here:
> > 			interrupt-map = <
> > 				/* IRQ mapping for pci slots and ALI M1533
> > 				 ...
> > 				 * management core also isn't used.
> > 				 */
> > 
> > 				/* IDSEL 0x16 / dev=6, bus=0 / PCI slot 3 */
> > 				0x3000 0 0 1 &xps_intc_0 3 2
> > 				0x3000 0 0 2 &xps_intc_0 2 2
> > 				0x3000 0 0 3 &xps_intc_0 5 2
> > 				0x3000 0 0 4 &xps_intc_0 4 2
> > 
> > Which gets preprocessed into:
> >            interrupt-map = <
> >         # 375 "arch/powerpc/boot/dts/virtex440-ml510.dts"
> >             0x3000 0 0 1 &xps_intc_0 3 2
> >             0x3000 0 0 2 &xps_intc_0 2 2
> >             0x3000 0 0 3 &xps_intc_0 5 2
> >             0x3000 0 0 4 &xps_intc_0 4 2
> > 
> > If I manually remove the "# 375 " line then that fixes the error
> > (although there is then a subsequent one of the same type).
> > 
> > I suppose this is a bug in dtc? It appears to have at least some
> > awareness of these preprocessor line number comments since it manages to
> > report the original source line number.
> 
> dtc is only able to track line numbers when the native /include/
> directive is used. The #include directive doesn't help it. It should be
> added, but until it is the following patch solves the problem:
> 
> I've got this patch in my tree. Either Rob or I will push it to Linus in
> the next few days.

Thanks, I'll do something similar in my device-tree.git tree.

Ian
