Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4D4AD7EE.90207@mentor.com>
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<1296697900-14004-3-git-send-email-meador_inge@mentor.com>
	<AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
	<4D4AD7EE.90207@mentor.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 3 Feb 2011 09:36:46 -0700
Message-ID: <AANLkTi=BjnRE=XKpahA4KTpBwMDoVMtLC3rtKKFWmkng@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: document the Open PIC device tree binding
To: Meador Inge <meador_inge@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Feb 3, 2011 at 9:29 AM, Meador Inge <meador_inge@mentor.com> wrote:
> On 02/03/2011 09:56 AM, Grant Likely wrote:
>>
>> On Wed, Feb 2, 2011 at 6:51 PM, Meador Inge<meador_inge@mentor.com>
>> =A0wrote:
>>>
>>> This binding documents several properties that have been in use for qui=
te
>>> some time, and adds one new property 'no-reset', which controls whether
>>> the
>>> Open PIC should be reset during runtime initialization.
>>>
>>> The general formatting and interrupt specifier definition is based off =
of
>>> Stuart Yoder's FSL MPIC binding.
>>>
>>> Signed-off-by: Meador Inge<meador_inge@mentor.com>
>>> CC: Hollis Blanchard<hollis_blanchard@mentor.com>
>>> CC: Stuart Yoder<stuart.yoder@freescale.com>
>>> ---
>>> =A0Documentation/powerpc/dts-bindings/open-pic.txt | =A0115
>>> +++++++++++++++++++++++
>>> =A01 files changed, 115 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt
>>>
>>> diff --git a/Documentation/powerpc/dts-bindings/open-pic.txt
>>> b/Documentation/powerpc/dts-bindings/open-pic.txt
>>> new file mode 100644
>>> index 0000000..447ef65
>>> --- /dev/null
>>> +++ b/Documentation/powerpc/dts-bindings/open-pic.txt
>>> @@ -0,0 +1,115 @@
>>> +* Open PIC Binding
>>> +
>>> +This binding specifies what properties must be available in the device
>>> tree
>>> +representation of an Open PIC compliant interrupt controller. =A0This
>>> binding is
>>> +based on the binding defined for Open PIC in [1] and is a superset of
>>> that
>>> +binding.
>>> +
>>> +PROPERTIES
>>> +
>>> + =A0NOTE: Many of these descriptions were paraphrased here from [1] to=
 aid
>>> + =A0 =A0 =A0 =A0readability.
>>> +
>>> + =A0- compatible
>>> + =A0 =A0 =A0Usage: required
>>> + =A0 =A0 =A0Value type:<string>
>>> + =A0 =A0 =A0Definition: Specifies the compatibility list for the PIC. =
=A0The
>>> + =A0 =A0 =A0 =A0 =A0property value shall include "open-pic".
>>> +
>>> + =A0- reg
>>> + =A0 =A0 =A0Usage: required
>>> + =A0 =A0 =A0Value type:<prop-encoded-array>
>>> + =A0 =A0 =A0Definition: Specifies the base physical address(s) and siz=
e(s) of
>>> this
>>> + =A0 =A0 =A0 =A0 =A0PIC's addressable register space.
>>> +
>>> + =A0- interrupt-controller
>>> + =A0 =A0 =A0Usage: required
>>> + =A0 =A0 =A0Value type:<empty>
>>> + =A0 =A0 =A0Definition: The presence of this property identifies the n=
ode
>>> + =A0 =A0 =A0 =A0 =A0as an Open PIC. =A0No property value should be def=
ined.
>>> +
>>> + =A0- #interrupt-cells
>>> + =A0 =A0 =A0Usage: required
>>> + =A0 =A0 =A0Value type:<u32>
>>> + =A0 =A0 =A0Definition: Specifies the number of cells needed to encode=
 an
>>> + =A0 =A0 =A0 =A0 =A0interrupt source. =A0Shall be 2.
>>> +
>>> + =A0- #address-cells
>>> + =A0 =A0 =A0Usage: required
>>> + =A0 =A0 =A0Value type:<u32>
>>> + =A0 =A0 =A0Definition: Specifies the number of cells needed to encode=
 an
>>> + =A0 =A0 =A0 =A0 =A0address. =A0The value of this property shall alway=
s be 0.
>>> + =A0 =A0 =A0 =A0 =A0As such, 'interrupt-map' nodes do not have to spec=
ify a
>>> + =A0 =A0 =A0 =A0 =A0parent unit address.
>>> +
>>> + =A0- no-reset
>>> + =A0 =A0 =A0Usage: optional
>>> + =A0 =A0 =A0Value type:<empty>
>>> + =A0 =A0 =A0Definition: The presence of this property indicates that t=
he PIC
>>> + =A0 =A0 =A0 =A0 =A0should not be reset during runtime initialization.=
 =A0The
>>> presence of
>>> + =A0 =A0 =A0 =A0 =A0this property also mandates that any initializatio=
n related to
>>> + =A0 =A0 =A0 =A0 =A0interrupt sources shall be limited to sources expl=
icitly
>>> referenced
>>> + =A0 =A0 =A0 =A0 =A0in the device tree.
>>
>> Please follow the lead set by the other binding documentation which is
>> more concise and tends to be of the form:
>>
>> =A0 =A0 Required properties:
>> =A0 =A0 =A0 =A0 - reg :<description>
>> =A0 =A0 =A0 =A0 - interrupt-controller :<description>
>>
>> =A0 =A0 Optional Properties:
>> =A0 =A0 =A0 =A0 - no-reset : blah
>
> OK, will do. =A0The one thing that I like about the other format, though,=
 is
> that it specifies the value type. =A0That is a useful addition.
>
>> I'm considering formalizing the binding format so that fully specified
>> and cross-referenced documentation can be generated from the bindings
>> directory.
>
> Formalizing the binding format would be great. =A0Perhaps we should add a
> HOWTO write a new binding document to the "Documentation" directory? The
> would be a great place to capture some of the common pitfalls that have b=
een
> coming up on the list lately (versioned compatibility tags, for example).
>
>> Also, to avoid the potential of a future namespace collision, it would
>> not be a bad idea to name this openpic-no-reset or something that
>> makes it clear that this is a binding specific property. =A0"no-reset"
>> sounds generic enough to give me pause.
>
> Isn't that a little redundant, though (e.g. "/soc/pic/openpic-no-reset")?
> =A0It is already scoped to the PIC node:
>
> =A0 mpic: pic@40000 {
> =A0 =A0 =A0compatible =3D "open-pic";
> =A0 =A0 =A0no-reset;
> =A0 };
>
> Or are you worried that someone will find the wrong "no-reset" property w=
hen
> searching from a location higher in the tree than the PIC node?
>
> I don't have a serious objection to the idea, but it seems slightly odd t=
o
> partially flatten the hierarchy back into the property names. =A0On the o=
ther
> hand, I do see the practical consideration of having a more unique proper=
ty
> which might prevent programming confusion/errors.

It's the sort of thing where properties with really generic names,
like no-reset, I could potentially see as gaining a meaning across the
whole tree.  For instance, in the not so distant past the 'status'
property was defined for all nodes to indicate whether or not the
device is usable.  If any binding defined status for its own purposes,
then it would now be broken.  It is worth a little bit of
consideration to avoid collisions with names that might gain a meaning
in the global domain.  I don't care much about what the specific name
is, and openpic-no-reset may indeed be a little long, so feel free to
suggest something that you like better.

g.

>
> --
> Meador Inge =A0 =A0 | meador_inge AT mentor.com
> Mentor Embedded | http://www.mentor.com/embedded-software
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
