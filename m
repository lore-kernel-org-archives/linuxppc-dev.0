From: benh@kernel.crashing.org
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Val Henson <val@nmt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Tue, 26 Mar 2002 22:40:52 +0100
Message-Id: <20020326214053.31653@mailhost.mipsys.com>
In-Reply-To: <3CA1031D.C072B4D6@mvista.com>
References: <3CA1031D.C072B4D6@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ben, et. al.,
>
>Sorry for dropping out the last few days, I've been very busy with other
>things.
>
>I've skimmed the email but I'll admit I didn't read them all in depth.
>I've made
>an example of actual bi_rec's using the ev64260 to see if my skimming
>worked :)
>In the example, I used a BI_STRUCT to pass in  the mac addr for the 3
embedded
>enet ctlrs on the gt64260.  I used the DEV_TYPE + DEV_CLASS concept but
>made an
>"EMBEDDED" DEV_TYPE to go along with DEV_PCI so we don't have to add a
new one
>for each embedded ctlr.  The square brackets are only there to make it
>easier to
>follow.  I'm assuming that every bi_rec is responsible for padding out to a
>4-byte boundary.  Is that what I'm supposed to do?
>
>Please let me know if I'm on the right track.  If so, we--the ev64260
>people--can
>flesh out some more bi_rec's and implement them.

Looks fine except for a couple of points:

 - BI_STRUCT is gone, it's BI_DEVICE and the first "type" field is gone,
that is BI_DEVICE just contains tags without a header. There is no need
to "know" if a given BI_REC is actually a struct or not, though if we
still want to do that for debugging reasons, we can define this info is
stored in the the high bit of the size field (and make sure bi_rec parsing
routines ignore that bit when reading size)

 - I'm not sure about the "EMBEDDED" dev type. I'd rather have a specific
type for EV64260_EMBEDDED, and another one for 405_EMBEDDED for example,
though this is mostly a matter of taste, we have enough room for types
to define as many as we want ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
