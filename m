Subject: Re: USB, 2.6-test11 and hot flaming death
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>,
	"tom_gall@mac.com" <tom_gall@mac.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031205233307.GA7462@ibrium.se>
References: <1070080961.683.26.camel@gaston>
	 <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
	 <20031204163433.GA21236@ibrium.se> <1070580925.613.7.camel@gaston>
	 <20031205233307.GA7462@ibrium.se>
Content-Type: text/plain
Message-Id: <1071447777.12498.398.camel@gaston>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 11:22:58 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having more reports of this USB problem on G5s, apparently
not always related to using old kbds...

In the dmesg log I have here, the problem starts with an error
in dl_resverse_done_list() where this case is triggered:

		if (!td) {
			ohci_err (ohci, "bad entry %8x\n", td_dma);
			break;
		}

It would be interesting, since you both have a 100% repro case,
to check out what URBs are filled in the lists and where do that
"bad" one comes from...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
