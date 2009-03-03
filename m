Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 484A6DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 02:23:39 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1537289ywb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Mar 2009 07:23:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a57485706bfc7aae2295acd743445312@localhost>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
	<a57485706bfc7aae2295acd743445312@localhost>
Date: Tue, 3 Mar 2009 08:23:37 -0700
Message-ID: <fa686aa40903030723p7d82edbfg5928adf9fe108b01@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2009 at 2:49 AM, Michael Guntsche <mike@it-loops.com> wrote:
> On Tue, 03 Mar 2009 08:35:02 +0100, Michael Guntsche <mike@it-loops.com>
> wrote:
>> As for adding additional information to the tree, can I also use libfdt
>> functions in platform/83xx/rbppc.c or is it better to do this via a
>> dedicated platform_init that simpleboot then uses?

I'd do this in the bootwrapper.  I think it is easier to follow and
understand that way.

> Sorry, please forget this quesiton. Of course simpleboot only reads the
> embedded tree
> so if I change the tree there it is the same as changing the initial DTS
> file.
> I will try to boot with a standard vmlinux image and then add the values in
> rbppc.c.

Okay, that makes more sense.  So, now if you want a common wrapper
image to boot on all of the routerboard variants, then you need to
pull all the tricks you have out of your hat to figure out what board
it is running on so that the .dtb can be updated.  Is there an eeprom
or something on the board which might store serial numbers or MAC
addresses?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
