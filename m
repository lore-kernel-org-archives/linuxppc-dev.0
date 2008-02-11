Return-Path: <therealshowman@yahoo.ca>
Received: from web32710.mail.mud.yahoo.com (web32710.mail.mud.yahoo.com
	[68.142.207.254]) by ozlabs.org (Postfix) with SMTP id 01EFDDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 09:04:57 +1100 (EST)
Date: Mon, 11 Feb 2008 17:04:56 -0500 (EST)
From: NM <therealshowman@yahoo.ca>
Subject: Re: MPC8272 FCC2 MDIO on Port D and FS_ENET
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <47B0C099.5030205@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-979257578-1202767496=:80613"
Message-ID: <231618.80613.qm@web32710.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-979257578-1202767496=:80613
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Scott,
I do boot from U-BOOT, via Ethernet, but I'd never set the MDIO/MDC in U-BOOT. Actually, looking at the u-boot 's MPC8260ADS.h now, it is still setting the default 8272ADS boards' PC18/19 for MDC/MDIO - and my unit is using PD23/29.
I guess U-BOOT is probably working (for me) since it probably defaults to the defaults of PHY and maybe not checking for PHY errors???

I guess, it is probably worthwhile having the MDIO/MDC pins also  set up explicitly in mpc8272_ads_pins as opposed to relying on the boot loader.







Scott Wood <scottwood@freescale.com> wrote: NM wrote:
> My problem is solved now after probing the lines, MDC was not showing 
> any activity.
> So, after explicitly setting the PD23 (MDC) to : OUTPUT/GPIO in 
> mpc8272_ads_pins and  it worked in
> 
> I'd previously thought about that, but I was sure that this was being 
> taken care of, but now that I'm thinking of it, I'm questioning my belief. 
> I think in the fs_enet/mii-bitbang.c: mdio_dir(..) it is supposed to 
> take care of this.

No, the mdc pin is static; only bits which need to be changed 
dynamically are dealt with in mii-bitbang.c.  Either the firmware or the 
platform code should set up static pins.

> But why I had to explictly set it initially beats me. 
> I wonder how this works in standard distribution.

It's probably set up by u-boot normally, at least if you boot from ethernet.

-Scott


       
---------------------------------
Looking for the perfect gift? Give the gift of Flickr!
--0-979257578-1202767496=:80613
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Scott,<br>I do boot from U-BOOT, via Ethernet, but I'd never set the MDIO/MDC in U-BOOT. Actually, looking at the u-boot 's MPC8260ADS.h now, it is still setting the default 8272ADS boards' PC18/19 for MDC/MDIO - and my unit is using PD23/29.<br>I guess U-BOOT is probably working (for me) since it probably defaults to the defaults of PHY and maybe not checking for PHY errors???<br><br>I guess, it is probably worthwhile having the MDIO/MDC pins also&nbsp; set up explicitly in mpc8272_ads_pins as opposed to relying on the boot loader.<br><br><br><br><br><br><br><br><b><i>Scott Wood &lt;scottwood@freescale.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> NM wrote:<br>&gt; My problem is solved now after probing the lines, MDC was not showing <br>&gt; any activity.<br>&gt; So, after explicitly setting the PD23 (MDC) to : OUTPUT/GPIO in <br>&gt; mpc8272_ads_pins and  it worked in<br>&gt;
 <br>&gt; I'd previously thought about that, but I was sure that this was being <br>&gt; taken care of, but now that I'm thinking of it, I'm questioning my belief. <br>&gt; I think in the fs_enet/mii-bitbang.c: mdio_dir(..) it is supposed to <br>&gt; take care of this.<br><br>No, the mdc pin is static; only bits which need to be changed <br>dynamically are dealt with in mii-bitbang.c.  Either the firmware or the <br>platform code should set up static pins.<br><br>&gt; But why I had to explictly set it initially beats me. <br>&gt; I wonder how this works in standard distribution.<br><br>It's probably set up by u-boot normally, at least if you boot from ethernet.<br><br>-Scott<br></blockquote><br><p>&#32;
      <hr size=1>
Looking for the perfect gift?<a href="http://www.flickr.com/gift/"><b> Give the gift of Flickr!</b></a>
--0-979257578-1202767496=:80613--
