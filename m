Message-ID: <004401c3c9c5$e9a327b0$5100a8c0@davey>
From: "Davey" <daveywu@transengines.com>
To: "Matt Porter" <mporter@kernel.crashing.org>,
	"Mark Powell" <medp@primagraphics.co.uk>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <C7FFFEA58B43D311920D0004ACE5333F10E4F46C@amer25.avnet.com> <29449.216.110.51.8.1071877375.squirrel@www.orkun.us> <1072105831.4163.15.camel@localhost.localdomain> <001d01c3c923$db2ca3c0$5100a8c0@davey> <3FE814FF.7020503@primagraphics.co.uk> <20031223101022.A23655@home.com>
Subject: Re: patch for ibm 405ep emac driver in linux-2.4.22 and 2.4.23
Date: Wed, 24 Dec 2003 10:30:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have test the way that Mark Powell provide and it doesn't work well. When I run "ifconfig eth1 up" I get output "SIOCSIFFLAGS: Device or resource busy".
I think we should fix more code as follow:

file: driver/net/ibm_emac/ibm_ocp_enet.c
------------------------------------------------------------------------------------------------------
--line 1150
/* Request our interrupt lines */
 rc = request_irq(dev->irq, emac_mac_irq, 0, "OCP EMAC MAC", dev);
 if (rc != 0)
  goto bail;
 --- rc = request_irq(fep->wol_irq, emac_wakeup_irq, 0, "OCP EMAC Wakeup", dev);
+++ rc = request_irq(fep->wol_irq, emac_wakeup_irq, SHIRQ, "OCP EMAC Wakeup", dev);
 if (rc != 0) {
  free_irq(dev->irq, dev);
  goto bail;
 }
-------------------------------------------------------------------------------------------------------

Davey Wu



----- Original Message -----
From: "Matt Porter" <mporter@kernel.crashing.org>
To: "Mark Powell" <medp@primagraphics.co.uk>
Cc: <linuxppc-embedded@lists.linuxppc.org>; "Davey" <daveywu@transengines.com>
Sent: Wednesday, December 24, 2003 1:10 AM
Subject: Re: patch for ibm 405ep emac driver in linux-2.4.22 and 2.4.23


>
> On Tue, Dec 23, 2003 at 10:12:15AM +0000, Mark Powell wrote:
> >
> > Davey wrote:
> >
> > >Some time ago Stefan and I had reported that both ethernet interfaces
> > >cannot work well together. Sorry I have lost all old mails when I
> > >reinstall my computer. We have find that this problem is caused by
> > >that the base address of eht1 is wrong set. Follow by my patch for
> > >linux-2.4.22 and linux-2.4.23. I have test the patch and it work well.
> >
> > shouldn't that just be:
>
> This is the right way to do it, we can't put that other hack in the
> kernel.  If somebody verifies this patch hen we can get it in.
>
> -Matt
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
