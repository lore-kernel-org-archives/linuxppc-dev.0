Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 646A8DE100
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 02:31:05 +1000 (EST)
Received: by gxk20 with SMTP id 20so7974538gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 09:31:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090519162511.7454D17E8058@mail19-dub.bigfish.com>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<20090519162511.7454D17E8058@mail19-dub.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 10:30:39 -0600
Message-ID: <fa686aa40905190930h54d22e2fj9c9cd4c9911aa485@mail.gmail.com>
Subject: Re: Musings on PCI busses
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 10:25 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>> 1) Probe the host controller in an of_platform driver. =A0This has the
>> advantage of simplicity. =A0The probe routine will get automatically
>> called when the PCI host controller device tree node is registered
>> with the of_platform bus. =A0The bus parenthood also gets reflected in
>> the device model and sysfs. =A0The disadvantage is that it defers PCI
>> bus probing until after the of_platform bus is probed (maybe this is
>> okay; maybe this already happens anyway).
>>
>> 2) Probe the host controller in an subsys_initcall(). =A0Advantage is
>> PCI can be probed earlier in the init path. =A0Disadvantages (minor) are
>> that it will always get called if the driver is enabled, and it needs
>> to manually search the device tree for PCI nodes.
>>
>> I'm leaning towards making it an of_platform driver. =A0Doing so also
>> makes it available to other powerpc processors (not just virtex) in
>> the case where a Xilinx FPGA is welded up to a discrete SoC and a host
>> controller instance is put into the FPGA. =A0(one of those weird things
>> people do when they have an FPGA in their system).
>
> I agree that something is called for... =A0The first might be slightly
> simpler, since it would probably transparently deal with the presence
> of more than one PLB->PCI bridge?

Yes, I think so.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
