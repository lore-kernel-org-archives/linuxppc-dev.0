Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091209.162121.256573183.davem@davemloft.net>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.161550.168794100.davem@davemloft.net>
	<20091209.162121.256573183.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 13:47:33 -0700
Message-ID: <fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
Subject: Re: Deprecating of_platform, the path from here...
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

On Wed, Dec 9, 2009 at 5:21 PM, David Miller <davem@davemloft.net> wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 09 Dec 2009 16:15:50 -0800 (PST)
>
>> From: Grant Likely <grant.likely@secretlab.ca>
>> Date: Wed, 9 Dec 2009 15:06:29 -0700
>>
>>> 1) of_platform will be deprecated in preference of the platform bus.
>>
>> What a shame, it's one of the cleanest driver probing models
>> in the tree.
>
> And BTW, have you folks who "decided" this considered at all the fact
> that it is much easier to describe represent platform devices using
> of OF devices rather than the other way around?

Yup.  I also think of_platform is a cleaner implementation than
platform, but the fact remains that there are far more platform
drivers than there are of_platform.  So, as nice as of_platform is, it
still does pretty much exactly the same job as platform.  I'd rather
see of_platform features migrated to platform than creating drivers
with dual registrations to be used on both OF and non-OF platforms.

Trying to go the other way around (deprecate platform and encouraging
of_platform instead) I don't think will gain much traction; whereas I
think bringing of_platform features into platform will be an easier
sell.  I'm trying to be pragmatic here.

> The platform device pdata mechanism requires data structure changes
> and is not dynamically extensible, whereas OF devices are
> fundamentally so.
>
> I don't like the idea to get rid of of_platform devices at all.

There are no plans to actually remove of_platform.  I certainly don't
plan to try and force SPARC to switch from of_platform to platform
bus.  But on PowerPC (and probably Microblaze) the plan is to move
away from of_platform for all the reasons discussed, and I'm not be
bringing of_platform over as I work on ARM support.

> OF devices are really clean, much like netlink messages, where
> arbitrary named attributes can be added or removed without any data
> structure changes at all.

No argument here.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
