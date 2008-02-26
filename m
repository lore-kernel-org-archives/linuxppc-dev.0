Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 5BDEADDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 01:27:27 +1100 (EST)
Message-ID: <47C41DBE.7090505@harris.com>
Date: Tue, 26 Feb 2008 09:10:06 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
References: <1203634340.10422.203.camel@pasglop>	<20080222192817.GA26211@ru.mvista.com>	<20080222144919.3ded7c54@weaponx>
	<47C40548.4080608@ru.mvista.com>
In-Reply-To: <47C40548.4080608@ru.mvista.com>
Content-Type: multipart/alternative;
	boundary="------------040801000000000604020902"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040801000000000604020902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


>>> +static inline void emac_rx_clk_default(struct emac_instance *dev)
>>> +{
>>> +	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
>>> +		unsigned long flags;
>>> +
>>> +		local_irq_save(flags);
>>> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) &
>>> +					~(SDR0_MFR_ECS >> dev->cell_index));
>>> +		local_irq_restore(flags);
>>> +	}
>>> +}
>>>       
>> Why did you do local_irq_save in these two functions?  mtdcri already
>> does spin_lock_irqsave...
>>
>> josh
>>     
>
> Oops, this got copy-pasted from the older ibm_emac.
> Thanks,
> Valentine.
> _______________________________________________
When I saw Josh's question, I thought the irq save/restore was there to
make the read-modify-write atomic; i.e. read SDR0_MFR, "AND" out some
bits, then write it back without the possibility of anything else
touching SDR0_MFR.  I'm just starting to get familiar with the kernel,
so if you have a chance, please help educate me.  Does the irq lock in
mtdcri protect the read-modify-write? Or maybe this R-M-W doesn't need
protecting?

    Steve


--------------040801000000000604020902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:47C40548.4080608@ru.mvista.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">
+static inline void emac_rx_clk_default(struct emac_instance *dev)
+{
+	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) &amp;
+					~(SDR0_MFR_ECS &gt;&gt; dev-&gt;cell_index));
+		local_irq_restore(flags);
+	}
+}
      </pre>
    </blockquote>
    <pre wrap="">Why did you do local_irq_save in these two functions?  mtdcri already
does spin_lock_irqsave...

josh
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Oops, this got copy-pasted from the older ibm_emac.
Thanks,
Valentine.
_______________________________________________</pre>
</blockquote>
<tt>When I saw Josh's question, I thought the irq save/restore was
there to make the read-modify-write atomic; i.e. read SDR0_MFR, "AND"
out some bits, then write it back without the possibility of anything
else touching </tt><tt>SDR0_MFR.&nbsp; I'm just starting to get familiar
with the kernel, so if you have a chance, please help educate me.&nbsp; Does
the irq lock in mtdcri protect the read-modify-write? Or maybe this
R-M-W doesn't need protecting?<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt>
</body>
</html>

--------------040801000000000604020902--
