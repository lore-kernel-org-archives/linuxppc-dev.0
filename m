From: benh@kernel.crashing.org
To: <yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Mon, 4 Feb 2002 19:15:38 +0100
Message-Id: <20020204181538.4089@mailhost.mipsys.com>
In-Reply-To: <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there>
References: <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Is this L3 cache problem with DOZE and NAP an errata for 7450?  I looked
>in the updates 7450 manual (with 7455 specifics already added to it) and I
>did not see any limitations on NAP or DOZE (it is 840 some pages long so
>perhaps I am not lookingin the right places yet).

No. It's 2 things. First the NAP must be disabled depending on the
errata (7450 + L3), but also, neither the 7450 nor the 7455 support
DOZE, they can only NAP or do nothing. Worst, on the 7455, it's bad
to set HID0:DOZE as it actually has a different meaning.

So let's split the can doze & can nap into 2 different features.

>> pmac_feature.c : add an entry in the machine table for your machine
>> based on OF "model" property.
>
>According to the Apple developers note just released for this machine its
>model ID is simply "PowerMac3,5" which is unchanged from previous versions
>and already covered in the pmac_feature.c file.

Ok.

>So I will spend my time reading up on NAP and DOZE and trying to see if
>and how that has changed since the 7450.
>
>Thanks for all your help!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
