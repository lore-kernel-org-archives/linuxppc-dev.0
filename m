Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90302B7D64
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 02:28:58 +1100 (EST)
In-Reply-To: <C13A88EA-3A60-41BB-BB26-C1DC9CF37422@kernel.crashing.org>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<C13A88EA-3A60-41BB-BB26-C1DC9CF37422@kernel.crashing.org>
Subject: Re: [PATCH 1/4] 8xx: Optimze TLB Miss handlers
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <OFBEBD40E8.1AAF1BAB-ONC12576D7.005493C7-C12576D7.0054C0CD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 27 Feb 2010 16:25:43 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote on 2010/02/26 21:10:31:
>
>
> On Feb 26, 2010, at 2:29 AM, Joakim Tjernlund wrote:
>
> >    li   r11, 0x00f0
> > -   rlwimi   r10, r11, 0, 24, 28   /* Set 24-27, clear 28 */
> > +   rlwimi   r10, r11, 0, 0x07f8   /* Set 24-27, clear 21-23,28 */
> >    DO_8xx_CPU6(0x2d80, r3)
> >    mtspr   SPRN_MI_RPN, r10   /* Update TLB entry */
>
> Cool, didn't know 'as' supported this notation.

Yeah, it was Scott who gave me the clue and from what I can tell it
is an official syntax form. I find much easier to understand.

 Jocke
