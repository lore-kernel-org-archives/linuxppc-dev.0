Date: Mon, 3 Feb 2003 09:32:16 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Yu Bo-BOYU1" <Bo.Yu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: powerpc board without RTC
Message-Id: <20030203093216.5e334e11.adrian@humboldt.co.uk>
In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC08AEB8E7@tx14exm05.ftw.mot.com>
References: <0B0A39652BB0D411BCCF00508B9512EC08AEB8E7@tx14exm05.ftw.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 2 Feb 2003 15:32:51 -0600
"Yu Bo-BOYU1" <Bo.Yu@motorola.com> wrote:
> Any recommendation how I should do to avoid RTC. I really don't care
> about time of day stuff except the system tick.

I've supported several boards like this. I recommend using the generic
RTC driver, and supplying a dummy initialisation routine.

In your setup_arch routine:

	    ppc_md.set_rtc_time = dummy_set_rtc_time;
	    ppc_md.get_rtc_time = dummy_get_rtc_time;

and the dummy code looks like:
static int dummy_set_rtc_time(unsigned long nowtime)
{
    	return -1;
}

static unsigned long dummy_get_rtc_time(void)
{
	/* Pick a date */
    	return mktime(2001, 1, 1, 12, 0, 0);
}

- Adrian Cox
http://www.humboldt.co.uk/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
