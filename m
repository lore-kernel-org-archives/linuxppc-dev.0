Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id DFFC367A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 23:56:22 +1000 (EST)
Message-ID: <427A2604.8040808@ru.mvista.com>
Date: Thu, 05 May 2005 17:56:20 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <4278DDA4.7060200@ru.mvista.com>
	<20050504164624.GB11439@gate.ebshome.net>
In-Reply-To: <20050504164624.GB11439@gate.ebshome.net>
Content-Type: multipart/alternative;
	boundary="------------090404050405060504000500"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 1/3] FCC Ethernet PlatformDevice support
 for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090404050405060504000500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eugene Surovegin wrote:

>On Wed, May 04, 2005 at 06:35:16PM +0400, Vitaly Bordug wrote:
>  
>
>>This patch adds generic PlatformDevice support to the 82xx family.
>>Only FCC's exist currently in the structure, as there is the driver 
>>which will utilize this.
>>
>>    
>>
>
>[snip]
>
>  
>
>>+#ifdef CONFIG_CPM2
>>+	identify_ppc_sys_by_id(cpm2_immr->im_memctl.memc_immr << 16);
>>+
>>+	/* Set up the MAC addresses for the FECs
>>+	 */
>>+	fec = ppc_sys_platform_devices[MPC82xx_FCC1].dev.platform_data;
>>+	memcpy(fec->mac_addr,bi->bi_enetaddr,6);
>>+
>>+	fec = ppc_sys_platform_devices[MPC82xx_FCC2].dev.platform_data;
>>+#ifdef CONFIG_ADS8272
>>+	memcpy(fec->mac_addr,bi->bi_enet1addr,6);
>>+#else
>>+	memcpy(fec->mac_addr,bi->bi_enetaddr,6);
>>+	fec->macaddr[5] ^= 1;
>>+#endif
>>+#endif
>>    
>>
>
>What is this? Why does common file contain board specific ifdefs????
>
>[snip]
>
>  
>
>>+/* FCC1 Clock Source Configuration.  There are board specific.
>>+   Can only choose from CLK9-12 */
>>+#if defined(CONFIG_ADS8272)
>>+#define F1_RXCLK	11
>>+#define F1_TXCLK	10
>>+#else
>>+#define F1_RXCLK	12
>>+#define F1_TXCLK	11
>>+#endif
>>    
>>
>
>Same thing. Why on earth you continue current 8xxx trend of putting 
>board specific crap into common files?
>
>  
>
>>+
>>+/* FCC2 Clock Source Configuration.  There are board specific.
>>+   Can only choose from CLK13-16 */
>>+#ifdef CONFIG_ADS8272
>>+#define F2_RXCLK	15
>>+#define F2_TXCLK	16
>>+#else
>>+#define F2_RXCLK	13
>>+#define F2_TXCLK	14
>>+#endif
>>    
>>
>
>Ditto.
>
>  
>
>>+#ifdef CONFIG_ADS8272
>>+#define PC_MDIO		0x00002000U
>>+#define PC_MDCK		0x00001000U
>>+#else
>>+#define PC_MDIO		0x00000004U
>>+#define PC_MDCK		0x00000020U
>>+#endif
>>    
>>
>
>Ditto.
>
>  
>
>>+				.name	= "phyinterrupt",
>>+				.start	= SIU_INT_IRQ5,
>>+				.end	= SIU_INT_IRQ5,
>>+				.flags	= IORESOURCE_IRQ,
>>+			},
>>    
>>
>
>Why is this here? PHY interrupt routing is _board_ specific.
>
>  
>
I have fixed these yet, but I think it will be more reasonable to update 
this together with respective driver which I'll work on together with 
Pantelis.
Thank you for review.

-- 
Sincerely, 
Vitaly


--------------090404050405060504000500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Eugene Surovegin wrote:
<blockquote cite="mid20050504164624.GB11439@gate.ebshome.net"
 type="cite">
  <pre wrap="">On Wed, May 04, 2005 at 06:35:16PM +0400, Vitaly Bordug wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">This patch adds generic PlatformDevice support to the 82xx family.
Only FCC's exist currently in the structure, as there is the driver 
which will utilize this.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
[snip]

  </pre>
  <blockquote type="cite">
    <pre wrap="">+#ifdef CONFIG_CPM2
+	identify_ppc_sys_by_id(cpm2_immr-&gt;im_memctl.memc_immr &lt;&lt; 16);
+
+	/* Set up the MAC addresses for the FECs
+	 */
+	fec = ppc_sys_platform_devices[MPC82xx_FCC1].dev.platform_data;
+	memcpy(fec-&gt;mac_addr,bi-&gt;bi_enetaddr,6);
+
+	fec = ppc_sys_platform_devices[MPC82xx_FCC2].dev.platform_data;
+#ifdef CONFIG_ADS8272
+	memcpy(fec-&gt;mac_addr,bi-&gt;bi_enet1addr,6);
+#else
+	memcpy(fec-&gt;mac_addr,bi-&gt;bi_enetaddr,6);
+	fec-&gt;macaddr[5] ^= 1;
+#endif
+#endif
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What is this? Why does common file contain board specific ifdefs????

[snip]

  </pre>
  <blockquote type="cite">
    <pre wrap="">+/* FCC1 Clock Source Configuration.  There are board specific.
+   Can only choose from CLK9-12 */
+#if defined(CONFIG_ADS8272)
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+#else
+#define F1_RXCLK	12
+#define F1_TXCLK	11
+#endif
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Same thing. Why on earth you continue current 8xxx trend of putting 
board specific crap into common files?

  </pre>
  <blockquote type="cite">
    <pre wrap="">+
+/* FCC2 Clock Source Configuration.  There are board specific.
+   Can only choose from CLK13-16 */
+#ifdef CONFIG_ADS8272
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+#else
+#define F2_RXCLK	13
+#define F2_TXCLK	14
+#endif
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ditto.

  </pre>
  <blockquote type="cite">
    <pre wrap="">+#ifdef CONFIG_ADS8272
+#define PC_MDIO		0x00002000U
+#define PC_MDCK		0x00001000U
+#else
+#define PC_MDIO		0x00000004U
+#define PC_MDCK		0x00000020U
+#endif
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ditto.

  </pre>
  <blockquote type="cite">
    <pre wrap="">+				.name	= "phyinterrupt",
+				.start	= SIU_INT_IRQ5,
+				.end	= SIU_INT_IRQ5,
+				.flags	= IORESOURCE_IRQ,
+			},
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why is this here? PHY interrupt routing is _board_ specific.

  </pre>
</blockquote>
I have fixed these yet, but I think it will be more reasonable to
update this together with respective driver which I'll work on together
with Pantelis.<br>
Thank you for review. <br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------090404050405060504000500--
