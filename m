Return-Path: <dan@embeddedalley.com>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by ozlabs.org (Postfix) with SMTP id B2455B7B68
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 05:08:09 +1100 (EST)
In-Reply-To: <1258195348-2861-5-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258195348-2861-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-5-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8F89F37D-4EC1-4B1B-AA89-5BFF5707E5F8@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
Date: Sat, 14 Nov 2009 10:08:43 -0800
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 14, 2009, at 2:42 AM, Joakim Tjernlund wrote:

> ..... Avoid this by always pinning
> kernel instruction TLB space.

You may as well map the data space, too, since you have
reserved the entries.  Take advantage of that performance.
Also, some processor variants have very few TLB entries,
and may only reserve two entries (although the flag says
reserve 4).  Ensure there are sufficient resources to do
what you want.  This is the reason the option is configurable.

Thanks.

	-- Dan
