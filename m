Date: Tue, 28 Aug 2001 14:37:50 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Henning Brinkmann <Henning.Brinkmann@offis.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pismo: How to check if the lid is closed.
In-Reply-To: <20010828095504.A1357@merope.informatik.uni-oldenburg.de>
Message-ID: <Pine.LNX.4.33.0108281353190.17831-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I found out from pmud's source code how to send it to sleep but I
> did not understand how to check if the lid is closed. I also had no
> luck searching for documentation about how to do it.

I think the lid state is encoded in the pmu data packets that pmud polls
for every second.

In poll_pmu():

	if (pmu_op(PMU_GET_COVER, 0, 0, &switches, 1, "switch req") < 0)
		return;

 	if ((switches & 1) != 0)
	{
	 	syslog(LOG_INFO, "lid closed: request sleep");
	 	chloralhydrate = 1;     /* lid is closed, go to sleep */
	}

So basically you need to send the PMU a specific request for information
(PMU_GET_COVER) and test bit 1 of the response byte.

> Does anyone have link to some documentation concerning that issue?

:-) This is Apple. The Darwin source might be your best bet. Or the pmud
source above, if you don't care about the meaning of the other bytes in
the PMU_GET_COVER response.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
