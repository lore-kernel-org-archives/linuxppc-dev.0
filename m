Return-Path: <kkboyanov@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id BEE0DDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 19:49:27 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1188210wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 02:49:25 -0700 (PDT)
Message-ID: <929bf310708210249x3cf8342aq4523d2a895d78eb@mail.gmail.com>
Date: Tue, 21 Aug 2007 11:49:25 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>
Subject: Re: Driver for device behind a PCI-VME bridge
In-Reply-To: <46CAA332.9060907@dutchspace.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_127555_31115001.1187689765534"
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
	<46C954AA.7050609@dutchspace.nl>
	<929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>
	<929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>
	<929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>
	<46CAA332.9060907@dutchspace.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_127555_31115001.1187689765534
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

I also work with devices on the VME bus. The approach we took is to map
> all the devices into userspace, and use Xenomai for RT performance. This
> avoids the need to write drivers for all the devices. The RT-performance
> of Xenomai is quite good: the jitter on a timer-interrupt is always less
> than 20usec, even under high load, where standard Linux only achieves
> this in a no load situatieo, under high load standard Linux has a jitter
> of over 10 msec.


Good advice, I will investigate in this direction.

The setup we choose was to have a RT-interrupt handler and a RT IOCTL
> call "WAIT_FOR_INTERRUPT". This is a slightly modified version from the
> Motorola driver (I guess that you also use the Tundra chipset to access
> the VME-bus).


Yes, I do. It is the Tsi148 in fact. I'll be interested to see some sample
code of yours, if it doesn't violate some restrictions ofcourse.

Here you can wait for a specific VME interrupt-level, and
> it returns the vector number. So you can have several applications
> connect to the same VME driver, but all on different levels.


So, if I understand you correctly, you altered the Motorola driver in order
for it to be able to communicate with user spae programms through Xenomai.
Which version of Xenomai ws that? I tried to test Xemonai 2.0 on my setup
but it iterfred somehow with SSH configuration and thats why i dropped it.

Many thanks,
Konstantin

------=_Part_127555_31115001.1187689765534
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<div>&nbsp;</div>
<div>Hi again,</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I also work with devices on the VME bus. The approach we took is to map<br>all the devices into userspace, and use Xenomai for RT performance. This
<br>avoids the need to write drivers for all the devices. The RT-performance<br>of Xenomai is quite good: the jitter on a timer-interrupt is always less<br>than 20usec, even under high load, where standard Linux only achieves
<br>this in a no load situatieo, under high load standard Linux has a jitter<br>of over 10 msec.</blockquote>
<div>&nbsp;</div>
<div>Good advice, I will investigate in this direction.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">The setup we choose was to have a RT-interrupt handler and a RT IOCTL<br>call &quot;WAIT_FOR_INTERRUPT&quot;. This is a slightly modified version from the
<br>Motorola driver (I guess that you also use the Tundra chipset to access<br>the VME-bus). </blockquote>
<div>&nbsp;</div>
<div>Yes, I do. It is the Tsi148 in fact. I&#39;ll be interested to see some sample code of yours, if it doesn&#39;t violate some restrictions ofcourse.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Here you can wait for a specific VME interrupt-level, and<br>it returns the vector number. So you can have several applications
<br>connect to the same VME driver, but all on different levels.</blockquote>
<div>&nbsp;</div>
<div>So, if I understand you correctly, you altered the Motorola driver in order for it to be able to communicate with user spae programms through Xenomai. Which version of Xenomai ws that? I tried to test Xemonai 2.0 on my setup but it iterfred somehow with SSH configuration and thats why i dropped it.
</div>
<div>&nbsp;</div>
<div>Many&nbsp;thanks,</div>
<div>Konstantin</div></div><br>

------=_Part_127555_31115001.1187689765534--
