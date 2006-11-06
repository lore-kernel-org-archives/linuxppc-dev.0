Return-Path: <tnt@246tNt.com>
Message-ID: <454EF4DF.7000808@246tNt.com>
Date: Mon, 06 Nov 2006 09:39:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>	
	<1162419138.25682.453.camel@localhost.localdomain>	
	<454A1C37.5050208@bplan-gmbh.de> <454A5952.6090801@bplan-gmbh.de>	
	<1162683341.28571.82.camel@localhost.localdomain>	
	<454D2FEC.3050605@246tNt.com>	
	<1162689227.28571.123.camel@localhost.localdomain>
	<528646bc0611052228j20a4c197x94da47467dce8d67@mail.gmail.com>
In-Reply-To: <528646bc0611052228j20a4c197x94da47467dce8d67@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 11/4/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> On Sun, 2006-11-05 at 01:27 +0100, Sylvain Munaut wrote:
>> > with a helper that would do
>> > - The find_node
>> >  - get_address / translate /  get_size
>> >  - ioremap
>> >
>> > Something like :
>> >
>> > intr = mpc52xx_find_and_map("mpc52xx-intr");
>> > sdma = mpc52xx_find_and_map("mpc52xx-sdma");
>>
>> Hrm... I don't care that much but I also don't think we need that
>> helper. It's not saving much.
>
> While on this topic... if a helper is added, what about it is 52xx
> specific?  Wouldn't the same code apply to all platforms?
>
> g.
>
The code would look like what I included at the end (untested). Not that
I used
of_find_by_name and not find_compatible. We can fix a naming convention
for those units ...

I think it does save quite a few lines and variable. It also simplifies the
error path ... granted it's not an exceptionnal reduction but still
worth it.
If it's not included now it's not that bad, I'll probably submitt a
patch later
when it's used in more places than mpc52xx_pic.c ...

About the use on other platform, maybe but do other platform need that a
lot ?
Here we have several unit that need to be mapped at different places ...


Sylvain


---

void __iomem *mpc52xx_find_and_map(const char *name)
{
        struct device_node *ofn;
        const u32 *regaddr_p;
        u64 regaddr64, size64;

        ofn = of_find_by_name(NULL, name);
        if (!ofn)
                return NULL;

        regaddr_p = of_get_address(ofn, 0, &size64, NULL);
        if (!regaddr_p) {
                of_node_put(ofn);
                return NULL;
        }

        regaddr64 = of_translate_address(ofn, regaddr_p);

        of_node_put(ofn);

        return ioremap((u32)regaddr64, (u32)size64);
}
