Return-Path: <glikely@secretlab.ca>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63FFF2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 04:22:46 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id fb11so739187pad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 09:22:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20121212171651.346b81ab@skate>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
 <50C60839.70603@monstr.eu> <20121210181525.3ccd87c6@skate>
 <50C66F3C.3010204@gmail.com> <20121212171651.346b81ab@skate>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 12 Dec 2012 17:22:22 +0000
Message-ID: <CACxGe6tdmFW9Y9Nub5qZMXg5mQHTgapxX3Yz67XpbrE=2PB5bg@mail.gmail.com>
Subject: Re: pci and pcie device-tree binding - range No cells
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Rob Herring <rob.herring@calxeda.com>, David Laight <David.Laight@aculab.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2012 at 4:16 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Rob Herring,
>
> On Mon, 10 Dec 2012 17:24:44 -0600, Rob Herring wrote:
>
>> > Marvell SoCs have up to 20 configurable address windows, which allow
>> > you, at run time, to say "I would like the range from physical
>> > address 0xYYYYYYYY to 0xZZZZZZZZ to correspond to the PCIe device
>> > in port 1, lane 2, or to the NAND, or to this or that device".
>> > Therefore, in the PCIe driver I proposed for the Armada 370/XP SoCs
>> > [1], there is no need to encode all those ranges statically in the
>> > DT.
>>
>> That's not a unique feature. I'm not sure if any powerpc systems do
>> that though.
>
> Yes, probably not an unique feature.
>
>> > The only "ranges" property I'm using is to allow the DT sub-nodes
>> > describing each PCIe port/lane to access the CPU registers that
>> > allow to see if the PCIe link is up or down, access the PCI
>> > configuration space and so on. So all ranges in my "ranges"
>> > property correspond to normal CPU registers, like the one you would
>> > put in the "reg" property for any device. The fact that those
>> > devices are PCIe is really orthogonal here.
>>
>> That doesn't really sound right.
>
> Very likely, but I still don't get what is "the right way".

Hi Thomas,

I just went and looked at your binding. Here's the snippet I found interesting:

pcie-controller {
+ compatible = "marvell,armada-370-xp-pcie";
+ status = "disabled";
+ #address-cells = <1>;
+ #size-cells = <1>;
+ ranges = <0       0xd0040000 0x2000 /* port0x1_port0 */
+  0x2000  0xd0042000 0x2000 /* port2x1_port0 */
+  0x4000  0xd0044000 0x2000 /* port0x1_port1 */
+  0x8000  0xd0048000 0x2000 /* port0x1_port2 */
+  0xC000  0xd004C000 0x2000 /* port0x1_port3 */
+  0x10000 0xd0080000 0x2000 /* port1x1_port0 */
+  0x12000 0xd0082000 0x2000 /* port3x1_port0 */
+  0x14000 0xd0084000 0x2000 /* port1x1_port1 */
+  0x18000 0xd0088000 0x2000 /* port1x1_port2 */
+  0x1C000 0xd008C000 0x2000 /* port1x1_port3 */>;
+
+ pcie0.0 at 0xd0040000 {
+ reg = <0x0 0x2000>;
+ interrupts = <58>;
+ clocks = <&gateclk 5>;
+ marvell,pcie-port = <0>;
+ marvell,pcie-lane = <0>;
+ status = "disabled";
+ };
+
+ pcie0.1 at 0xd0044000 {
+ reg = <0x4000 0x2000>;
+ interrupts = <59>;
+ clocks = <&gateclk 5>;
+ marvell,pcie-port = <0>;
+ marvell,pcie-lane = <1>;
+ status = "disabled";
+ };
[... rest trimmed for berevity]

You're right, if you're doing dynamic allocation of windows, then you
really don't need to have a ranges property. However, the way the PCI
node is set up definitely looks incorrect.

PCI already has a very specific binding for pci host controller nodes.
First, #address-cells=<3>; #size-cells=<2>; and device_type="pcie"
must be there. You don't want to break this. You can find details on
the pci and pci-express binding here:
http://www.openfirmware.org/1275/bindings/pci/pci2_1.pdf
http://www.openfirmware.org/1275/bindings/pci/pci-express.txt

For the child nodes, PCI is a discoverable bus, so normally I wouldn't
expect to see child nodes at all when using a dtb. The only time nodes
should be populated is when a device has non-discoverable
charactersitics. In your example above you do have some additional
data, but I don't know enough about pci-express to say how best to
encode them or whether they are needed at all. Ben might have some
thoughts on this.

When the PCI child nodes are present, it is important to stick with
the established PCI addressing scheme which uses 3 cells for
addressing. The first entry in the reg property must represent the
configuration space so that DT nodes can be matched up with discovered
devices. There is no requirement to include mappings for the memory
and io regions if the host controller can assign them dynamically.

I don't think you should need a ranges property at all for what you're
doing. Access to config space is generally managed by the PCI host
controller drivers and subsystem, and PCI device drivers don't
typically use of_ calls directly.

g.
