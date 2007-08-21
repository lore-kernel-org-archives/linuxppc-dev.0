Return-Path: <scottwood@freescale.com>
Message-ID: <46CB12DB.3020505@freescale.com>
Date: Tue, 21 Aug 2007 11:29:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 17/20] bootwrapper: Add PlanetCore firmware support.
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174008.GP30562@ld0162-tx32.am.freescale.net>
	<20070821031658.GQ15469@localhost.localdomain>
In-Reply-To: <20070821031658.GQ15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>>+void planetcore_prepare_table(char *table)
>>+{
>>+	int last_was_newline = 0;
>>+
>>+	while (*table != 10 || !last_was_newline) {
>>+		if (*table == 10) {
>>+			*table = 0;
>>+			last_was_newline = 1;
>>+		} else {
>>+			last_was_newline = 0;
>>+		}
>>+
>>+		table++;
>>+	}
> 
> 
> Hrm.. this loop makes my brain hurt.  It's correct as far as I can
> determine what it's supposed to be doing, but I think there's got to
> be a way to make what it's doing a little more obvious.

How about something like this:

char last = 0;

while (1) {
	if (*table == '\n') {
		*table = 0;

		if (last == *table)
			return;
	}

	last = *table++;
}

-Scott
