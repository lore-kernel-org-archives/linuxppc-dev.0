Return-Path: <bhelgaas@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1D84B71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 09:19:41 +1000 (EST)
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com
	[172.25.149.7]) by smtp-out.google.com with ESMTP id p4JNJWhM016010
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 16:19:32 -0700
Received: from ywf7 (ywf7.prod.google.com [10.192.6.7])
	by hpaq7.eem.corp.google.com with ESMTP id p4JNJU9Y017523
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 16:19:31 -0700
Received: by ywf7 with SMTP id 7so1438799ywf.41
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:19:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305846751.7481.55.camel@pasglop>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
	<BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
	<BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
	<BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
	<1305846751.7481.55.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 19 May 2011 17:19:10 -0600
Message-ID: <BANLkTi=bs31L=C+XWGeXG49xuFVzt+omgA@mail.gmail.com>
Subject: Re: Kernel cannot see PCI device
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Prashant Bhole <prashantsmailcenter@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 5:12 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2011-05-19 at 11:58 -0600, Bjorn Helgaas wrote:
>> The scan below PCIX0 (bus 0001:00) doesn't find anything. =A0You really
>> need a powerpc expert to help here, but in their absence, my guess
>> would be something's wrong with config space access, so I would start
>> by just adding some printks to ppc4xx_probe_pcix_bridge() to see if
>> the rsrc_cfg address looks reasonable. =A0You might need a chip spec or
>> maybe you can compare it to the device tree (I have no idea what the
>> relation between the device tree and OF is).
>>
>> You mentioned the u-boot "pci 2" command earlier. =A0It found a device
>> on bus 2, which means there must be at least one P2P bridge to get you
>> from bus 0 to bus 2. =A0So the output of "pci 0", "pci 1", "pci 80", and
>> "pci 81" (to compare with what Linux found) would be interesting.
>
> Well, if it's PCIe, there's the "virtual" P2P bridge of the root
> complex.
>
> The question is on what PCIe is his device connected, the one that we
> see or the one that's disabled in the device-tree.

I *think* the device Prashant is looking for ("02.00.00   0x1000
0x0072     Mass storage controller 0x00") is below the PCI-X bridge;
at least the canyonlands.dts he posted says that PCIX0 leads to buses
0-3f.
