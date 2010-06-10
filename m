Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276152275.1962.61.camel@pasglop>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141018.25879.44413.stgit@angua>
	<1276152275.1962.61.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 08:28:34 -0600
Message-ID: <AANLkTikg1hLdV_OUjc3QIhFatP_iLfVClhzmyixmjje1@mail.gmail.com>
Subject: Re: [PATCH 5/5] of/address: restrict 'no-ranges' kludge to powerpc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 12:44 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
>> Certain Apple machines don't use the ranges property correctly, but the
>> workaround should not be applied on other architectures. =A0This patch
>> disables the workaround for non-powerpc architectures.
>
> I'm half tempted to add it to the quirk list (which should really be
> made generic) so I can disable it on more 'modern' powerpc as well.

In the mean time, are you okay with this version of the patch?

g.

>
> Cheers,
> Ben.
>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> CC: Stephen Rothwell <sfr@canb.auug.org.au>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: devicetree-discuss@lists.ozlabs.org
>> ---
>> =A0drivers/of/address.c | =A0 11 ++++++++++-
>> =A01 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 0b04137..5c220c3 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -346,12 +346,21 @@ static int of_translate_one(struct device_node *pa=
rent, struct of_bus *bus,
>> =A0 =A0 =A0 =A0* a 1:1 translation at that level. It's up to the caller =
not to try
>> =A0 =A0 =A0 =A0* to translate addresses that aren't supposed to be trans=
lated in
>> =A0 =A0 =A0 =A0* the first place. --BenH.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* As far as we know, this damage only exists on Apple machi=
nes, so
>> + =A0 =A0 =A0* This code is only enabled on powerpc. --gcl
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 ranges =3D of_get_property(parent, rprop, &rlen);
>> +#if !defined(CONFIG_PPC)
>> + =A0 =A0 if (ranges =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OF: no ranges; cannot translate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 }
>> +#endif /* !defined(CONFIG_PPC) */
>> =A0 =A0 =A0 if (ranges =3D=3D NULL || rlen =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D of_read_number(addr, na);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(addr, 0, pna * 4);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: no ranges, 1:1 translation\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: empty ranges; 1:1 translation\n"=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> =A0 =A0 =A0 }
>>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
