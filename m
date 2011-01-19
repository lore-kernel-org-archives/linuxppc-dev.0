Return-Path: <meador_inge@mentor.com>
Message-ID: <4D374899.20402@mentor.com>
Date: Wed, 19 Jan 2011 14:24:57 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: document the MPIC device tree binding
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150306A7A2@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150306A7A2@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/18/2011 02:21 PM, Yoder Stuart-B08248 wrote:
>>   Documentation/powerpc/dts-bindings/mpic.txt |   78
>
> This is really the binding for an open-pic interrupt controller
> and I think the name should reflect that-- open-pic.txt.

Yup, agreed.

>> +This binding specifies what properties and child nodes must be
>> +available on the device tree representation of the "MPIC" interrupt
>> +controller.  This binding is based on the binding defined for Open PIC
>> +in [1] and is a superset of that binding.
>
> I think it would be better to base this on the ePAPR binding which
> was based on the original chrp binding.  Properties like "name"
> and "device_type" are deprecated not being used in flat device trees.
>
> <http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf>
>
> The proposed new properties really should go back into the ePAPR.

I read portions of ePAPR while writing this binding and considered that. 
  My only worry was that ePAPR is focused on embedded systems and this 
binding will have to cover non-embedded systems that exist in the 
kernel.  However, perhaps that is not a legitimate concern?

>> +
>> +** Required properties:
>> +
>> +   NOTE: Many of these descriptions were paraphrased from [1] to aid
>> +         readability.
>> +
>> +   - name : Specifies the name of the MPIC.
>
> Drop this.  No DTS files use it.

Done.

>> +   - device_type : Specifies the device type of this MPIC.  The value
>> + of this
>> +                   property shall be "open-pic".
>
> device_type is deprecated, since this is not real open-firmware.  In
> practice the kernel is matching on device_type, but we want to move
> away from that to match on "compatible", just hasn't been implemented
> yet.

I will drop this property with the expectation that the kernel will be 
fixed.  From a quick grep of '.../arch/powerpc' it looks like most uses 
are of the form:

     np = of_find_node_by_type(NULL, "open-pic");
     if (np == NULL)
        return;

In most of these cases I suppose the 'of_find_node_by_type' calls could 
just be replaced with calls to 'of_find_compatible_node(NULL, "open-pic")'.


>> +   - reg : Specifies the base physical address(s) and size(s) of this
>> + MPIC's
>> +           addressable register space.
>> +   - compatible : Specifies the compatibility list for the MPIC.  The
>> + property
>> +                  value shall include "chrp,open-pic".
>
> In the ePAPR we modified this to just "open-pic", because this has
> nothing to do with chrp anymore.   I think just "open-pic" is
> what we want.

OK, but as a migration path we should allow the kernel to accept both 
(Scott mentioned this in another reply), but "open-pic" is the 
documented correct way.

>> +   - interrupt-controller : The presence of this property identifies
>> + the node
>> +                            as a MPIC.  No property value should be
>> defined.
>> +   - #address-cells : Specifies the number of cells needed to encode an
>> +                      address.  The value of this property shall always
>> + be 0
>> +                      so that 'interrupt-map' nodes do not have to
>> + specify a
>> +                      parent unit address.
>> +   - #interrupt-cells : Specifies the number of cells needed to encode
>> + an
>> +                        interrupt source.
>
> Should be 2, correct?

Yup.

>> +** Optional properties:
>> +
>> +   - no-reset : The presence of this property indicates that the MPIC
>> +                should not be reset during runtime initialization.
>> +   - protected-sources : Specifies a list of interrupt sources that are
>> + not
>> +                         available for use and whose corresponding
>> + vectors
>> +                         should not be initialized.  A typical use case
>> + for
>> +                         this property is in AMP systems where multiple
>> +                         independent operating systems need to share
>> + the MPIC
>> +                         without clobbering each other.
>
> I do think you need to include the definition of interrupt
> specifiers here.   Feel free to cut/paste text from my
> Freescale mpic binding.

OK, I will look into that.  Thanks.


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
