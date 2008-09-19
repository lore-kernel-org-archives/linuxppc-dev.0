Return-Path: <abg.mur22@yahoo.com>
Received: from n20.bullet.mail.mud.yahoo.com (n20.bullet.mail.mud.yahoo.com
	[68.142.206.147]) by ozlabs.org (Postfix) with SMTP id 9FB3BDE11A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 02:43:06 +1000 (EST)
Date: Fri, 19 Sep 2008 09:43:04 -0700 (PDT)
From: Abg Abg <abg.mur22@yahoo.com>
Subject: Re: Network driver on ppc 405EX
To: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1621726146-1221842584=:99067"
Message-ID: <557947.99067.qm@web59707.mail.ac4.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1621726146-1221842584=:99067
Content-Type: text/plain; charset=us-ascii

The device is enabled via pci_enable_device. pci_request_region also succeeds.
pci_resource_start(pdev, 0) is what is returning zero.

The same driver works on boards with different ppc processor (440SPe).

Thanks
Abg


----- Original Message ----
From: Marco Stornelli <marco.stornelli@coritel.it>
To: Abg Abg <abg.mur22@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Sent: Friday, September 19, 2008 12:35:33 PM
Subject: Re: Network driver on ppc 405EX

Have you already enabled the device? You can enable it with
pci_enable_device. Then you can call the pci_request_region and then the
ioremap. In addition, you can check the pci configuration with the
command lspci. You can found an example on Linux Device Drivers.

Regards.

Abg Abg ha scritto:
> Hi, 
>   Hope this is the correct list for driver related queries for ppc boards
> 
> I was porting a network driver for a ppc 405EX based embedded system (kilauea config).
> The module builds fine and loads and I see the probe routine get called correctly.
> However when I try remapping the BAR0 address from the PCI config space, the ioremap fails.
> A little debugging showed that the address passed to ioremap was zero.
> I pass the address to the ioremap via pci_resource_start(pdev, 0) where pdev is a type struct pci_dev *.
> 
> I dumped the contents of the pdev and saw that the vendor-id, device id etc were correct, however the BAR0 address seemed to be all zeroes.
> 
> The question that I had was
> 1. Is there any kernel config that needs to be done for PCI devices to be able to remap the BAR0 addresses.
> 2. Any other kernel parameter that needs to be tweaked?
> 
> Thanks,
> Abg
> 
> 
>      
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838



      
--0-1621726146-1221842584=:99067
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">The device is enabled via pci_enable_device. pci_request_region also succeeds.<br>pci_resource_start(pdev, 0) is what is returning zero.<br><br>The same driver works on boards with different ppc processor (440SPe).<br><br>Thanks<br>Abg<br><br><div style="font-family: arial,helvetica,sans-serif; font-size: 13px;">----- Original Message ----<br>From: Marco Stornelli &lt;marco.stornelli@coritel.it&gt;<br>To: Abg Abg &lt;abg.mur22@yahoo.com&gt;<br>Cc: linuxppc-embedded@ozlabs.org<br>Sent: Friday, September 19, 2008 12:35:33 PM<br>Subject: Re: Network driver on ppc 405EX<br><br>
Have you already enabled the device? You can enable it with<br>pci_enable_device. Then you can call the pci_request_region and then the<br>ioremap. In addition, you can check the pci configuration with the<br>command lspci. You can found an example on Linux Device Drivers.<br><br>Regards.<br><br>Abg Abg ha scritto:<br>&gt; Hi, <br>&gt;&nbsp;  Hope this is the correct list for driver related queries for ppc boards<br>&gt; <br>&gt; I was porting a network driver for a ppc 405EX based embedded system (kilauea config).<br>&gt; The module builds fine and loads and I see the probe routine get called correctly.<br>&gt; However when I try remapping the BAR0 address from the PCI config space, the ioremap fails.<br>&gt; A little debugging showed that the address passed to ioremap was zero.<br>&gt; I pass the address to the ioremap via pci_resource_start(pdev, 0) where pdev is a type struct pci_dev *.<br>&gt; <br>&gt; I dumped the contents of the pdev and saw that
 the vendor-id, device id etc were correct, however the BAR0 address seemed to be all zeroes.<br>&gt; <br>&gt; The question that I had was<br>&gt; 1. Is there any kernel config that needs to be done for PCI devices to be able to remap the BAR0 addresses.<br>&gt; 2. Any other kernel parameter that needs to be tweaked?<br>&gt; <br>&gt; Thanks,<br>&gt; Abg<br>&gt; <br>&gt; <br>&gt;&nbsp; &nbsp; &nbsp;  <br>&gt; <br>&gt; <br>&gt; ------------------------------------------------------------------------<br>&gt; <br>&gt; _______________________________________________<br>&gt; Linuxppc-embedded mailing list<br>&gt; <a ymailto="mailto:Linuxppc-embedded@ozlabs.org" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br>-- <br>Marco Stornelli<br>Embedded Software Engineer<br>CoRiTeL - Consorzio
 di Ricerca sulle Telecomunicazioni<br><a href="http://www.coritel.it" target="_blank">http://www.coritel.it</a><br><br><a ymailto="mailto:marco.stornelli@coritel.it" href="mailto:marco.stornelli@coritel.it">marco.stornelli@coritel.it</a><br>+39 06 72582838<br></div></div></div><br>

      </body></html>
--0-1621726146-1221842584=:99067--
