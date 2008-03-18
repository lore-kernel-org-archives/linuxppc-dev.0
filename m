Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E5A7EDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 11:26:52 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Mar 2008 17:43:37 CST."
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
Date: Tue, 18 Mar 2008 01:26:50 +0100
Sender: wd@denx.de
Message-Id: <20080318002650.AE701246C5@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant,

in message <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com> you wrote:
> 
> However, I have declined (for now) to pick up the defconfigs for those
> boards and instead merged in the config features they require into the
> mpc5200 defconfig.  My primary reason for doing so is to increase the
> likelyhood that full featured kernels are built and tested so that
> situations where board ports conflict with each other are caught and
> fixed.

I know what you mean, and I agree with the idea.

Unfortunately I think it's impossible to implement, especially on such
embedded processors with their high level of pin multiplexing.

For example, if you want to  include  testing  of  the  FEC  ethernet
driver,  you  will probably fail to test the second USB port. I think
it's simply not possible to test all possible  options  in  a  single
kernel  configuration - first it doesn't work (for example because of
pin multiplexing issues), second you will likely not be able to  find
hardware that implements all features at once.

My dream is to have a distributed  test  environment  -  a  framework
which  can  be used for automatic testing which includes building and
running the code on a set of systems, and which will then report  the
test results to a central location.

We have the same problem  (probably  to  a  much  higher  degree)  in
U-Boot;  nobody  can test all board configurations because nobody has
all the cross-tools installed nor the 500+ boards available.

> ojn has also been complaining about the number of defconfigs he needs
> to build to test all the powerpc configurations without any
> indications about which ones are important and which ones are not.

again, some distributed test tool might help - we would get not  only
information  abouyt  test results, but also which configurations have
been tested how frequently.

> There has been some discussion about having a subdirectory for
> optimized board configs, but nobody has done anything about it yet.

Is this a hint?

> The one part that I have a really strong opinion on is that there
> should be a full featured mpc5200 defconfig for build testing.  Beyond
> that (and if ojn can also be appeased) I can probably be convinced.  :-)

Maybe my expectations for "full featured' are just too high..

> The LED code just hasn't been picked up.  IIRC, it was reworked to
> make it a proper driver in drivers/leds.  I need to look at it again,
> but it is a lot of code for a very simple thing and I wasn't sure if I
> should be the one to pick it up because it is in drivers/leds which
> has a different maintainer.

I see. Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If some day we are defeated, well, war has  its  fortunes,  good  and
bad.
	-- Commander Kor, "Errand of Mercy", stardate 3201.7
