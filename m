Return-Path: <meador_inge@mentor.com>
Message-ID: <4D4AD7EE.90207@mentor.com>
Date: Thu, 03 Feb 2011 10:29:34 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/3] powerpc: document the Open PIC device tree binding
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<1296697900-14004-3-git-send-email-meador_inge@mentor.com>
	<AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
In-Reply-To: <AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/03/2011 09:56 AM, Grant Likely wrote:
> On Wed, Feb 2, 2011 at 6:51 PM, Meador Inge<meador_inge@mentor.com>  wrote:
>> This binding documents several properties that have been in use for quite
>> some time, and adds one new property 'no-reset', which controls whether the
>> Open PIC should be reset during runtime initialization.
>>
>> The general formatting and interrupt specifier definition is based off of
>> Stuart Yoder's FSL MPIC binding.
>>
>> Signed-off-by: Meador Inge<meador_inge@mentor.com>
>> CC: Hollis Blanchard<hollis_blanchard@mentor.com>
>> CC: Stuart Yoder<stuart.yoder@freescale.com>
>> ---
>>   Documentation/powerpc/dts-bindings/open-pic.txt |  115 +++++++++++++++++++++++
>>   1 files changed, 115 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt
>>
>> diff --git a/Documentation/powerpc/dts-bindings/open-pic.txt b/Documentation/powerpc/dts-bindings/open-pic.txt
>> new file mode 100644
>> index 0000000..447ef65
>> --- /dev/null
>> +++ b/Documentation/powerpc/dts-bindings/open-pic.txt
>> @@ -0,0 +1,115 @@
>> +* Open PIC Binding
>> +
>> +This binding specifies what properties must be available in the device tree
>> +representation of an Open PIC compliant interrupt controller.  This binding is
>> +based on the binding defined for Open PIC in [1] and is a superset of that
>> +binding.
>> +
>> +PROPERTIES
>> +
>> +  NOTE: Many of these descriptions were paraphrased here from [1] to aid
>> +        readability.
>> +
>> +  - compatible
>> +      Usage: required
>> +      Value type:<string>
>> +      Definition: Specifies the compatibility list for the PIC.  The
>> +          property value shall include "open-pic".
>> +
>> +  - reg
>> +      Usage: required
>> +      Value type:<prop-encoded-array>
>> +      Definition: Specifies the base physical address(s) and size(s) of this
>> +          PIC's addressable register space.
>> +
>> +  - interrupt-controller
>> +      Usage: required
>> +      Value type:<empty>
>> +      Definition: The presence of this property identifies the node
>> +          as an Open PIC.  No property value should be defined.
>> +
>> +  - #interrupt-cells
>> +      Usage: required
>> +      Value type:<u32>
>> +      Definition: Specifies the number of cells needed to encode an
>> +          interrupt source.  Shall be 2.
>> +
>> +  - #address-cells
>> +      Usage: required
>> +      Value type:<u32>
>> +      Definition: Specifies the number of cells needed to encode an
>> +          address.  The value of this property shall always be 0.
>> +          As such, 'interrupt-map' nodes do not have to specify a
>> +          parent unit address.
>> +
>> +  - no-reset
>> +      Usage: optional
>> +      Value type:<empty>
>> +      Definition: The presence of this property indicates that the PIC
>> +          should not be reset during runtime initialization.  The presence of
>> +          this property also mandates that any initialization related to
>> +          interrupt sources shall be limited to sources explicitly referenced
>> +          in the device tree.
>
> Please follow the lead set by the other binding documentation which is
> more concise and tends to be of the form:
>
>      Required properties:
>          - reg :<description>
>          - interrupt-controller :<description>
>
>      Optional Properties:
>          - no-reset : blah

OK, will do.  The one thing that I like about the other format, though, 
is that it specifies the value type.  That is a useful addition.

> I'm considering formalizing the binding format so that fully specified
> and cross-referenced documentation can be generated from the bindings
> directory.

Formalizing the binding format would be great.  Perhaps we should add a 
HOWTO write a new binding document to the "Documentation" directory? 
The would be a great place to capture some of the common pitfalls that 
have been coming up on the list lately (versioned compatibility tags, 
for example).

> Also, to avoid the potential of a future namespace collision, it would
> not be a bad idea to name this openpic-no-reset or something that
> makes it clear that this is a binding specific property.  "no-reset"
> sounds generic enough to give me pause.

Isn't that a little redundant, though (e.g. 
"/soc/pic/openpic-no-reset")?  It is already scoped to the PIC node:

    mpic: pic@40000 {
       compatible = "open-pic";
       no-reset;
    };

Or are you worried that someone will find the wrong "no-reset" property 
when searching from a location higher in the tree than the PIC node?

I don't have a serious objection to the idea, but it seems slightly odd 
to partially flatten the hierarchy back into the property names.  On the 
other hand, I do see the practical consideration of having a more unique 
property which might prevent programming confusion/errors.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
