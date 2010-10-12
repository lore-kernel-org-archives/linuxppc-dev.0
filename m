Return-Path: <john.williams@petalogix.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 270EDB6F11
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 14:02:18 +1100 (EST)
Received: by fxm5 with SMTP id 5so897773fxm.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 20:02:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=dU4oYfqrBGYmSCmYf2cRsBX-Pf6A9X9N0YaZA@mail.gmail.com>
References: <1d3f23371002091921m7f47a1fbt1cf7fd2ef0a927fa@mail.gmail.com>
	<AANLkTi=dU4oYfqrBGYmSCmYf2cRsBX-Pf6A9X9N0YaZA@mail.gmail.com>
Date: Tue, 12 Oct 2010 13:02:16 +1000
Message-ID: <AANLkTimAKXb=iRGOZKDOcELBdNhrDs8pd_yLMt1MD10Y@mail.gmail.com>
Subject: Re: PPC: Possible bug in prom_parse.c:of_irq_map_raw?
From: John Williams <john.williams@petalogix.com>
To: Grant Likely <grant.likely@secretlab.ca>
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

Hi Grant,

On Fri, Oct 8, 2010 at 4:34 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> Reaching way back into the past....

Indeed

> John, did you ever solve your issue here? =A0Comments below.

The fix in our case was to explicitly add child nodes to the PCI
controller, with interrupt-parent and interrupts properties. The
product in question had a fixed set of devices on the PCI bus, so this
was not a problem.

So, it's not really resolved so much as avoided.

Other comments below:

>> Perhaps this is my misunderstanding, but I'm looking at the bit of
>> code in of_irq_map_raw() that iterates the interrupt-map DTS node,
>> which I am seeing to behave strangely when handling the interrupt-map
>> property on a PCI bridge node.
>>
>> Early in the function, we get the #address-cells value from the node -
>> in this case the PCI bridge, and store it in local var addrsize:
>>
>> =A0 =A0 =A0 =A0/* Look for this #address-cells. We have to implement the=
 old linux
>> =A0 =A0 =A0 =A0 * trick of looking for the parent here as some device-tr=
ees rely on it
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0old =3D of_node_get(ipar);
>> =A0 =A0 =A0 =A0do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(old, "#address-ce=
lls", NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tnode =3D of_get_parent(old);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_put(old);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0old =3D tnode;
>> =A0 =A0 =A0 =A0} while(old && tmp =3D=3D NULL);
>> =A0 =A0 =A0 =A0of_node_put(old);
>> =A0 =A0 =A0 =A0old =3D NULL;
>> =A0 =A0 =A0 =A0addrsize =3D (tmp =3D=3D NULL) ? 2 : *tmp;
>>
>> =A0 =A0 =A0 =A0DBG(" -> addrsize=3D%d\n", addrsize);
>>
>>
>> Later, once we've found the interrupt-map and are iterating over it
>> attempting to match on PCI device addresses, there is this little
>> fragment:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get the interrupt pare=
nt */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (of_irq_workarounds & =
OF_IMAP_NO_PHANDLE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newpar =
=3D of_node_get(of_irq_dflt_pic);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newpar =
=3D
>> of_find_node_by_phandle((phandle)*imap);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imap++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--imaplen;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Check if not found */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (newpar =3D=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG(" -> =
imap parent not found !\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get #interrupt-cells a=
nd #address-cells of new
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * parent
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(n=
ewpar, "#interrupt-cells", NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp =3D=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG(" -> =
parent lacks #interrupt-cells !\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newintsize =3D *tmp;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(n=
ewpar, "#address-cells", NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newaddrsize =3D (tmp =3D=
=3D NULL) ? 0 : *tmp;
>>
>> Finally, later in the loop we update addrsize=3Dnewaddrsize
>>
>> As I read this code, and the behaviour I'm seeing, is that if the
>> interrupt controller parent device doesn't have an #address-cells
>> entry, then this get_property will return fail, therefore setting
>> newaddrsize =A0to zero. =A0This then means that subsequent match attempt=
s
>> when iterating the interrupt-map always fail, because the match length
>> (addrsize) is 0.
>
> Correct. =A0The interrupt-map property contains the following fields:
>
> child-unit-address child-irq irq-controller irq-parent-unit-address paren=
t-irq
>
> In the *vast majority* of cases, the irq-parent-unit-address is a
> zero-length field because #address-cells isn't present on the
> interrupt controller parent. =A0So effectively interrupt-map becomes:
>
> child-unit-address child-irq irq-controller parent-irq
>
> See epapr 1.0 for a full discussion
>
>>
>> Maybe I'm missing something here, but shouldn't this last bit of code
>> instead be:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D of_get_property(n=
ewpar, "#address-cells", NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newaddrsize =3D (tmp =3D=
=3D NULL) ? addrsize : *tmp;
>>
>> =A0^^^^^^^^^
>> ?
>>
>> In other words, if the parent node has an #address-cells value, then
>> use it, otherwise stick to the #address-cells value we picked up for
>> the actual node in question (ie the PCI bridge).
>
> No, because at this point we absolutely do want to know how big the
> parent #address-cells is, and if it is missing, we need to use 0. =A0If
> the child's addrsize continued to be used, then the interrupt-map
> parsing would get unaligned.
>
> The inner loop is over the entries in interrupt-map. =A0addrsize and
> intsize are only updated in the case where a match is found in the
> table. =A0If a match isn't found, then it should bail out to the 'fail'
> label.
>
>> The way this is manifesting itself in the system I'm looking at is
>> that only the PCI device matching the first entry in the PCI bridge
>> interrupt-map property is correctly matching. For PCI devices that
>> require more than one pass through the interrupt-map loop, addrsize
>> goes to zero and no further match is possible.
>
> Something sounds fishy. =A0If you're still having problems, can you
> enable #define DEBUG in drivers/of/irq.c and post the output?

OK, this may take me a lilttle while as the test system is in storage!

Thanks,

John
