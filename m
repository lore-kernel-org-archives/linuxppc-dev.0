From: benh@kernel.crashing.org
To: <paulus@samba.org>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	<linux-galileo@source.mvista.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 merge warning
Date: Wed, 3 Apr 2002 09:53:34 +0100
Message-Id: <20020403085334.6438@mailhost.mipsys.com>
In-Reply-To: <15531.32246.283097.469203@argo.ozlabs.ibm.com>
References: <15531.32246.283097.469203@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Interesting...  I hope we're not going to end up with a lot of extra
>complexity for not very much gain, though.  If we are going to have a
>more complex bi_rec setup, let's make sure that it is capable of
>expressing a complete device tree.  If not then I would prefer to see
>a minimal amount of extra complexity.
>
>In other words I think there are 2 tenable positions: the minimal one,
>which just adds a BI_MAC_ADDR and maybe a BI_GT64260_ADDR tag to the
>existing list of tags (and makes no change to the bi_rec structure),
>and a full-featured one which allows for a tree of device records with
>each device having a list of properties, each with a string name and
>arbitrary binary data.

Well, have you read the previous discussion ? We finally managed to
agree on some mecanism after much arguments, and now you come up with
something different :)

What I'm coming up with is 2 more functions that allow to 1) find
a bi_rec by tag (so one don't have to modify the parse loop in setup.c
to locate a bi_rec), and 2) find a BI_DEVICE record based on BI_DEV_TYPE
and BI_DEV_ID within it. (the first function has the ability to look
for bi_recs within a bi_rec). That, along with some code to handle
saving the bi_recs in a persistent place and retreiving them by pointer.

Now that you have the functions, how you use them is up to you. I define
a simple mecanism for devices (BI_DEVICE composite rec with BI_DEV_TYPE
and BI_DEV_ID tags to locate it). That record contains whatever you want
to pass to your device.

It is _not_ intended, at first, to act like a device tree. Most embedded
targets really don't need that, it's more intended to pass _only_ those
informations that may be variable to a given driver. That is things like
HW MAC address, and eventually, interrupt routing, chipselect routing for
external bus peripherials, but that's completely up to a given board
designer to decide what he wants to retreive from bi_recs and what is
hard coded in the driver.

In my case, I know I will pass all the chipselect & interrupt routing
informations for my non-OCP peripherials, but that isn't mandatory.

Confusing ? Well... The mecanism is very simple, flexible enough for
you to be able to use as a kind of device-tree if you like, but enough
people here expressed the need NOT to use it as a device tree. I know
for example most OCP peripherials _could_ be indeed described with
bi_recs, but it's up to the 4xx/8xx platform maintainer to decide how
he wants to deal with those.

Now, it would be nice if all of this could be discussed around a table
at OLS, do you have plans to schedule a PPC BOF there ? :)


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
