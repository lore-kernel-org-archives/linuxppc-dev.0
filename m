From: benh@kernel.crashing.org
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Aurel Wisse <aurel_wisse@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	yddev <yellowdog-devel@lists.terrasoftsolutions.com>
Subject: Re: Sungem with iMac Rev-B
Date: Tue, 30 Apr 2002 19:20:46 +0100
Message-Id: <20020430182047.17947@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.33.0204301829360.30445-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.33.0204301829360.30445-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>
>> No, you mismatched bmac and gmac. The sungem driver obsoletes
>> the gmac one, not the bmac one.
>>
>> The bmac driver currently don't have PHY control. This could
>> eventually be added, since I beleive we actually know how to
>> tap the PHY registers when available. Though this need some
>> work and I have no hardware to test on, so I'd rather see
>> someone who has do the job ;)
>
>Throw some hints (what to write where, approximately) my way and I might
>give it a shot.

Well, driver side, look at the ethtool ioctl implementation in sungem, and
do something around those lines. You probably first need to properly detect
the PHY type by reading the 2 PHY_ID registers, then act depending on the PHY.

sungem has a mecanism that tries to fallback to fixed settings when autoneg
fails, you may want to skip that part though as it's a bit tricky.

Normally autoneg is enabled/disabled in the PHY control register, along with
the forced 10/100 modes and duplex mode. Look at what darwin does here.

Note that all this is only valid if you have an MII PHY, I don't think the
early bmac do that (bitbanging ?). You should probably make sure you have
a bmac+ and skip all the code (return fixed speed from ethtool ioctls)
on older bmac.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
