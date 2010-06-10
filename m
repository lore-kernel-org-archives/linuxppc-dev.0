Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100610154741.GA7484@oksana.dev.rtsoft.ru>
References: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
	<AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 10:30:26 -0600
Message-ID: <AANLkTimjIyclTWZZW1A26zOcWroK-bwOkmEqsLm4DINk@mail.gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org, "M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 9:47 AM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Thu, Jun 10, 2010 at 09:13:57AM -0600, M. Warner Losh wrote:
> [...]
>> : >> I told you several ways of how to improve the code (based on
>> : >> the ideas from drivers/base/, so the ideas aren't even mine,
>> : >> fwiw).
>> : >
>> : > I tend to agree with Anton here.
>> :
>> : The reason I'm confident doing it that way is that it is *not* a
>> : structure. =A0There is no structure relationship between the resource
>> : table and the platform_device other than they are allocated with the
>> : same kzalloc() call. =A0All the code that cares about that is containe=
d
>> : within 4 lines of code. =A0I'm resistant to using a structure because =
it
>> : is adds an additional 5-6 lines of code to add a structure that won't
>> : be used anywhere else, and is only 4 lines to begin with.
>>
>> I tend to agree with Grant here. =A0The idiom he's using is very wide
>> spread in the industry and works extremely well. =A0It keeps the
>> ugliness confined to a couple of lines and is less ugly than the
>> alternatives for this design pattern. =A0It is a little surprising when
>> you see the code the first time, granted, but I think its expressive
>> power trumps that small surprise.
>
> Oh, come on. Both constructions are binary equivalent.
>
> So how can people seriously be with *that* code:
>
> =A0 =A0 =A0 =A0dev->resource =3D (void *)&dev[1];
>
> which, semantically, is a nonsense and asks for a fix.
>
> While
> =A0 =A0 =A0 =A0dev_obj->dev.resource =3D dev_obj->resource;
>
> simply makes sense.

Well, my choices are (without whitespace so as not to bias line count):

A)
struct of_device *alloc_function(int num_res)
{
	struct device *ofdev;
	struct resource *res;
	ofdev =3D kzalloc(sizeof(*ofdev) + (sizeof(*res) * num_res), GFP_KERNEL);
	if (!ofdev)
		return NULL;
	res =3D (struct resource *)&ofdev[1];
	...
	return ofdev;
}
10 lines of code

B)
struct of_device_object {
	struct of_device ofdev;
	struct resource resource[0];
};
struct of_device *alloc_function(int num_res)
{
	struct of_device_object *ofobj;
	struct of_device *ofdev;
	struct resource *res;
	ofobj =3D kzalloc(sizeof(*ofobj) + (sizeof(*res) * num_res), GFP_KERNEL);
	if (!ofobj)
		return NULL;
	res =3D ofobj->resource;
	...
	return &ofobj->ofdev;
}
15 lines of code

C)
struct of_device *alloc_function(int num_res)
{
	struct device *ofdev;
	struct resource *res;
	ofdev =3D kzalloc(sizeof(*ofdev), GFP_KERNEL)
	if (!ofdev)
		return NULL;
	res =3D kzalloc((sizeof(*res) * num_res), GFP_KERNEL);
	if (!res) {
		kfree(ofdev);  /* or goto an error unwind label */
		return NULL;
	}
	res =3D (struct resource *)&ofdev[1];
	...
	return ofdev;
}
15 lines of code, plus an extra few lines at kfree(ofdev) time.

When I look at the three, option A is more concise and clearer in it's
intent to me.

That being said, I'm looking at refactoring to use
platform_device_alloc() instead, which is effectively option C. (which
I'd normally avoid, but it removes otherwise duplicate code from
drivers/of).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
