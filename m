Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 03038B6EEC
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 05:34:32 +1100 (EST)
Received: by gwj15 with SMTP id 15so96167gwj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Oct 2010 11:34:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1d3f23371002091921m7f47a1fbt1cf7fd2ef0a927fa@mail.gmail.com>
References: <1d3f23371002091921m7f47a1fbt1cf7fd2ef0a927fa@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 7 Oct 2010 12:34:09 -0600
Message-ID: <AANLkTi=dU4oYfqrBGYmSCmYf2cRsBX-Pf6A9X9N0YaZA@mail.gmail.com>
Subject: Re: PPC: Possible bug in prom_parse.c:of_irq_map_raw?
To: John Williams <john.williams@petalogix.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Michal Simek <michal.simek@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reaching way back into the past....

John, did you ever solve your issue here?  Comments below.

On Tue, Feb 9, 2010 at 8:21 PM, John Williams
<john.williams@petalogix.com> wrote:
> Hi,
>
> Perhaps this is my misunderstanding, but I'm looking at the bit of
> code in of_irq_map_raw() that iterates the interrupt-map DTS node,
> which I am seeing to behave strangely when handling the interrupt-map
> property on a PCI bridge node.
>
> Early in the function, we get the #address-cells value from the node -
> in this case the PCI bridge, and store it in local var addrsize:
>
> =A0 =A0 =A0 =A0/* Look for this #address-cells. We have to implement the =
old linux
> =A0 =A0 =A0 =A0 * trick of looking for the parent here as some device-tre=
es rely on it
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0old =3D of_node_get(ipar);
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(old, "#address-cel=
ls", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tnode =3D of_get_parent(old);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_put(old);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0old =3D tnode;
> =A0 =A0 =A0 =A0} while(old && tmp =3D=3D NULL);
> =A0 =A0 =A0 =A0of_node_put(old);
> =A0 =A0 =A0 =A0old =3D NULL;
> =A0 =A0 =A0 =A0addrsize =3D (tmp =3D=3D NULL) ? 2 : *tmp;
>
> =A0 =A0 =A0 =A0DBG(" -> addrsize=3D%d\n", addrsize);
>
>
> Later, once we've found the interrupt-map and are iterating over it
> attempting to match on PCI device addresses, there is this little
> fragment:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get the interrupt paren=
t */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (of_irq_workarounds & O=
F_IMAP_NO_PHANDLE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newpar =3D=
 of_node_get(of_irq_dflt_pic);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newpar =3D
> of_find_node_by_phandle((phandle)*imap);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imap++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--imaplen;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Check if not found */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (newpar =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG(" -> i=
map parent not found !\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get #interrupt-cells an=
d #address-cells of new
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * parent
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(ne=
wpar, "#interrupt-cells", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG(" -> p=
arent lacks #interrupt-cells !\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newintsize =3D *tmp;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(ne=
wpar, "#address-cells", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newaddrsize =3D (tmp =3D=
=3D NULL) ? 0 : *tmp;
>
> Finally, later in the loop we update addrsize=3Dnewaddrsize
>
> As I read this code, and the behaviour I'm seeing, is that if the
> interrupt controller parent device doesn't have an #address-cells
> entry, then this get_property will return fail, therefore setting
> newaddrsize =A0to zero. =A0This then means that subsequent match attempts
> when iterating the interrupt-map always fail, because the match length
> (addrsize) is 0.

Correct.  The interrupt-map property contains the following fields:

child-unit-address child-irq irq-controller irq-parent-unit-address parent-=
irq

In the *vast majority* of cases, the irq-parent-unit-address is a
zero-length field because #address-cells isn't present on the
interrupt controller parent.  So effectively interrupt-map becomes:

child-unit-address child-irq irq-controller parent-irq

See epapr 1.0 for a full discussion

>
> Maybe I'm missing something here, but shouldn't this last bit of code
> instead be:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(ne=
wpar, "#address-cells", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newaddrsize =3D (tmp =3D=
=3D NULL) ? addrsize : *tmp;
>
> =A0^^^^^^^^^
> ?
>
> In other words, if the parent node has an #address-cells value, then
> use it, otherwise stick to the #address-cells value we picked up for
> the actual node in question (ie the PCI bridge).

No, because at this point we absolutely do want to know how big the
parent #address-cells is, and if it is missing, we need to use 0.  If
the child's addrsize continued to be used, then the interrupt-map
parsing would get unaligned.

The inner loop is over the entries in interrupt-map.  addrsize and
intsize are only updated in the case where a match is found in the
table.  If a match isn't found, then it should bail out to the 'fail'
label.

> The way this is manifesting itself in the system I'm looking at is
> that only the PCI device matching the first entry in the PCI bridge
> interrupt-map property is correctly matching. For PCI devices that
> require more than one pass through the interrupt-map loop, addrsize
> goes to zero and no further match is possible.

Something sounds fishy.  If you're still having problems, can you
enable #define DEBUG in drivers/of/irq.c and post the output?

> I might be able to hack around this in the device-tree by setting
> #address-cells=3D<3> in the interrupt controller node, but that doesn't
> smell right either - it's only true for PCI devices for a start,
> whereas this controller handles interrupts from many sources on the
> 32-bit PLB bus as well. =A0I looked at the ML510 DTS in boot/dts and
> it's not doing anything like this.

Yeah, that's not right, and it would mess up the interrupt-map
parsing.  You'd end up with more hard to debug problems.

g.
