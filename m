Message-ID: <3906FA44.2EBD53FA@relog.ch>
Date: Wed, 26 Apr 2000 16:16:36 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <Pine.LNX.4.21.0004261635150.27506-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:

> the second r128 will never be able to pick the right device
> (/dev/fb1 here) the BusID line is more or less ignored in the fbdev
> case so the second driver will open /dev/fb0 which will result
> in a kernel crash.

Doesn't r128 support the "fbdev" option to specify the framebuffer device?

Here's the important code from the glint driver:


	for (i = 0; i < numDevSections; i++) {
 	    dev = xf86FindOptionValue(devSections[i]->options,"fbdev");
 	    if (devSections[i]->busID) {
 		xf86ParsePciBusString(devSections[i]->busID,&bus,&device,&func);
 		if (!xf86CheckPciSlot(bus,device,func))
 		    continue;
 	    }
 	    if (fbdevHWProbe(NULL,dev,&name)) {
 		ScrnInfoPtr pScrn;

  				/* Check for pm2fb */
 		if (strcmp(name,"Permedia2")) continue;
 		foundScreen = TRUE;
 		pScrn = NULL;

 		if (devSections[i]->busID) {
 		    /* XXX what about when there's no busID set? */
 		    int entity;
 		    entity = xf86ClaimPciSlot(bus,device,func,drv,
 					      0,devSections[i],
 					      TRUE);
 		    pScrn = xf86ConfigPciEntity(pScrn,0,entity,
 						      NULL,RES_SHARED_VGA,
 						      NULL,NULL,NULL,NULL);
 		    if (pScrn)
  			xf86DrvMsg(pScrn->scrnIndex, X_CONFIG,
  				   "claimed PCI slot %d:%d:%d\n",bus,device,func);
 		} else {



Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
