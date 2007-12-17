Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id E9803DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 02:19:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so610094anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 07:19:50 -0800 (PST)
Message-ID: <fa686aa40712170719o29da3caew43d65225feea9ba@mail.gmail.com>
Date: Mon, 17 Dec 2007 08:19:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
In-Reply-To: <20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/13/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> This now better describes what the UBoot device tree generator actually does.  In particular:
>
> 1) Nodes have a label derived from the device name, and a node name
> derived from the device type.
> 2) Usage of compound nodes (representing more than one device in the same IP) which actually works.  This requires having a valid compatible node, and all the other things that a bus normally has.  I've chosen 'xlnx,compound' as the bus name to describe these compound nodes.
> 3) Uartlite requires a port-number property for the console to work.
>
> In addition, I've clarified some of the language relating to how mhs
> nodes should be represent in the device tree.

Thanks for the updates.  Comments below.

> ---
>  Documentation/powerpc/booting-without-of.txt |   61 +++++++++++++++-----------
>  1 files changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..5e2b85a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2276,7 +2276,7 @@ platforms are moved over to use the flattened-device-tree model.
>     properties of the device node.  In general, device nodes for IP-cores
>     will take the following form:
>
> -       (name)@(base-address) {
> +       (name): (ip-core-name)@(base-address) {

(name): (generic-name)@(base-address) {

>                 compatible = "xlnx,(ip-core-name)-(HW_VER)"
>                              [, (list of compatible devices), ...];
>                 reg = <(baseaddr) (size)>;
> @@ -2294,9 +2294,9 @@ platforms are moved over to use the flattened-device-tree model.
>                         dropped from the parameter name, the name is converted
>                         to lowercase and all underscore '_' characters are
>                         converted to dashes '-'.
> -       (baseaddr):     the C_BASEADDR parameter.
> +       (baseaddr):     the baseaddr parameter value (often named C_BASEADDR).
>         (HW_VER):       from the HW_VER parameter.
> -       (size):         equals C_HIGHADDR - C_BASEADDR + 1
> +       (size):         the address range size (often C_HIGHADDR - C_BASEADDR + 1).

Ah, yes.  Good clarification.

>
>     Typically, the compatible list will include the exact IP core version
>     followed by an older IP core version which implements the same
> @@ -2326,12 +2326,13 @@ platforms are moved over to use the flattened-device-tree model.
>
>     becomes the following device tree node:
>
> -       opb-uartlite-0@ec100000 {
> +       opb_uartlite_0: serial@ec100000 {
>                 device_type = "serial";
>                 compatible = "xlnx,opb-uartlite-1.00.b";
>                 reg = <ec100000 10000>;
> -               interrupt-parent = <&opb-intc>;
> +               interrupt-parent = <&opb_intc_0>;
>                 interrupts = <1 0>; // got this from the opb_intc parameters
> +               port-number = <0>;
>                 current-speed = <d#115200>;     // standard serial device prop
>                 clock-frequency = <d#50000000>; // standard serial device prop
>                 xlnx,data-bits = <8>;
> @@ -2339,16 +2340,19 @@ platforms are moved over to use the flattened-device-tree model.
>                 xlnx,use-parity = <0>;
>         };
>
> -   Some IP cores actually implement 2 or more logical devices.  In this case,
> -   the device should still describe the whole IP core with a single node
> -   and add a child node for each logical device.  The ranges property can
> -   be used to translate from parent IP-core to the registers of each device.
> -   (Note: this makes the assumption that both logical devices have the same
> -   bus binding.  If this is not true, then separate nodes should be used for
> -   each logical device).  The 'cell-index' property can be used to enumerate
> -   logical devices within an IP core.  For example, the following is the
> -   system.mhs entry for the dual ps2 controller found on the ml403 reference
> -   design.
> +   Some IP cores actually implement 2 or more logical devices.  In
> +   this case, the device should still describe the whole IP core with
> +   a single node and add a child node for each logical device.  The
> +   ranges property can be used to translate from parent IP-core to the
> +   registers of each device.  In addition, the parent node should be
> +   compatible with the bus type 'xlnx,compound', and should contain
> +   #address-cells and #size-cells, as with any other bus.  (Note: this
> +   makes the assumption that both logical devices have the same bus
> +   binding.  If this is not true, then separate nodes should be used
> +   for each logical device).  The 'cell-index' property can be used to
> +   enumerate logical devices within an IP core.  For example, the
> +   following is the system.mhs entry for the dual ps2 controller found
> +   on the ml403 reference design.
>
>         BEGIN opb_ps2_dual_ref
>                 PARAMETER INSTANCE = opb_ps2_dual_ref_0
> @@ -2370,21 +2374,24 @@ platforms are moved over to use the flattened-device-tree model.
>
>     It would result in the following device tree nodes:
>
> -       opb_ps2_dual_ref_0@a9000000 {
> +       opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "xlnx,compound";
>                 ranges = <0 a9000000 2000>;
>                 // If this device had extra parameters, then they would
>                 // go here.
> -               ps2@0 {
> +               opb-ps2-dual-ref@0 {

According to the generic names recommendation, this should be either
"keyboard@0" or "mouse@0", but of course the two interfaces are
identical and EDK doesn't have any information about how they are
used.  Perhaps the node name should be: "ps2@0".  David, thoughts?

>                         compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
>                         reg = <0 40>;
> -                       interrupt-parent = <&opb-intc>;
> +                       interrupt-parent = <&opb_intc_0>;
>                         interrupts = <3 0>;
>                         cell-index = <0>;
>                 };
> -               ps2@1000 {
> +               opb-ps2-dual-ref@1000 {
>                         compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
>                         reg = <1000 40>;
> -                       interrupt-parent = <&opb-intc>;
> +                       interrupt-parent = <&opb_intc_0>;
>                         interrupts = <3 0>;
>                         cell-index = <0>;
>                 };
> @@ -2447,17 +2454,18 @@ platforms are moved over to use the flattened-device-tree model.
>
>     Gives this device tree (some properties removed for clarity):
>
> -       plb-v34-0 {
> +       plb_v34 {

Steve, when I wrote this I was lazy and I didn't add the bus address.
However, if we don't have the base address I think we'll end up with
name collisions (especially in the MPMC case).  So, based on generic
names convention, this should probably simply be "plb@<baseaddr>".

>                 #address-cells = <1>;
>                 #size-cells = <1>;
> +               compatible = "xlnx,plb-v34-1.02.a";
>                 device_type = "ibm,plb";
>                 ranges; // 1:1 translation
>
> -               plb-bram-if-cntrl-0@ffff0000 {
> +               plb_bram_if_cntrl_0: plb-bram-if-cntrl@ffff0000 {

Node name should probably just be "bram@ffff0000" here.

>                         reg = <ffff0000 10000>;
>                 }
>
> -               opb-v20-0 {
> +               opb_v20 {

opb@<baseaddr>

>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges = <20000000 20000000 20000000
> @@ -2465,11 +2473,11 @@ platforms are moved over to use the flattened-device-tree model.
>                                   80000000 80000000 40000000
>                                   c0000000 c0000000 20000000>;
>
> -                       opb-uart16550-0@a0000000 {
> +                       opb_uart16550_0: opb-uart16550@a0000000 {

serial@a0000000

>                                 reg = <a00000000 2000>;
>                         };
>
> -                       opb-intc-0@d1000fc0 {
> +                       opb_intc_0: opb-intc@d1000fc0 {

interrupt-controller@d1000fc0

>                                 reg = <d1000fc0 20>;
>                         };
>                 };
> @@ -2513,6 +2521,9 @@ platforms are moved over to use the flattened-device-tree model.
>
>        Requred properties:
>         - current-speed : Baud rate of uartlite
> +               Optional properties:
> +       - port-number : unique ordinal index of the device. This
> +         property is required for a console on uartlite.

And has already been discussed, drop the port-number property.  I'll
rework the uartlite driver to use aliases instead.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
