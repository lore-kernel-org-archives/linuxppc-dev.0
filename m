From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	"Mark A. Greer" <mgreer@mvista.com>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Tue, 26 Mar 2002 22:52:35 +0100
Message-Id: <20020326215235.21322@mailhost.mipsys.com>
In-Reply-To: <0203270237.AA03006@ivan.Harhan.ORG>
References: <0203270237.AA03006@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>It would set a very bad example if it is implemented. In your proposal the
>records containing the GT-64260 Ethernet information have no indication
>in them
>whatsoever that they are for GT-64260 and not some other Ethernet. If
you make
>the gt64260_eth driver call a function to grab all bi_recs of this kind, the
>next engineer who designs a board with other hard-wired Ethernet
interfaces on
>it besides the GT-64260 (like an MPC8260 + GT-64260 system) will be simply
>stuck out of luck as the gt64260_eth driver will unceremoniously grab all
>records for all Ethernets and there will be no way to tell which MAC address
>belongs to each Ethernet.

Yah, this is why BI_DEV_TYPE should be GT64260_xxxx

We have several choices here for the design, I'm not sure which is best, so
please speak up:

When dealing with combo-chips like the GT or PPC 4xx/8xx etc..., we can
either:

 - define one BI_DEV_TYPE per chip (BI_DEV_TYPE_GT64260, ...). The actual
device within the GT64260 (ethernet in our case) is referenced via the
BI_DEV_CLASS (ethernet), BI_DEV_ID beeing optionally there in case a
given device in the chip exist in more than one instance.

 - define one BI_DEV_TYPE per chip (same as above), and define a BI_DEV_ID
containing both function and the index (for example 'ETH0') thus we don't
need BI_DEV_CLASS.

 - define a specific BI_DEV_TYPE for each function (that is
BI_DEV_TYPE_GT64260_ETH), BI_DEV_ID is only an index.

I tend to prefer solution 2)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
