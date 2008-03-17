Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 399E9DE012
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:28:38 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Mar 2008 15:43:43 CST."
	<fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
Date: Mon, 17 Mar 2008 23:28:36 +0100
Sender: wd@denx.de
Message-Id: <20080317222836.AFA66241A2@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com> you wrote:
>
> b) defconfigs is more about testing and a known working configuration
> than it is about a distribution configuration.  It's not intended to
> be the deployed config.  For a distribution/deployable image it is
> expected that the engineer responsible will tailor the config.

This may be true in general, but for the boards in question it is
definitely incorrect:

* The TQM5200 configuration as provided is intended for  shipping  as
  default  configuration  for  this board. The "engineer responsible"
  already *did* the tailoring and put that  state  in  the  defconfig
  file.

* The CM5200 and Motion-Pro boards are custom designs, where the
  defconfig file matches exactly the requirements of the respective
  customers.

I feel it is very important to be able to include this  configuration
information  somewhere  with  the  kernel source tree - and to me the
defconfig file for a board is the most  natural  place  to  put  such
information.

Please understand that we do  NOT  expect  the  end  user  having  to
"tailor  the  config"  -  instead,  we  want  to  provide  a  default
configuration that can be used as is,  at  least  for  default  usage
cases.


If you don't want to use a board specific default configuration, then
please tell me what the recommended way is to provide a knwon  to  be
working,  tested  *and*  *useful*  default  configuration  for custom
boards in the Linux kernel tree?


> All these boards are supported with
> arch/powerpc/platforms/mpc5200_simple.c.  A kernel built for that
> platform will boot on any of those boards as long as it is passed the
> correct device tree.

I don't doubt that the kernel will boot. But that does not mean  that
it   is  ready  for  use  for  the  intended  purpose.  For  example,
arch/powerpc/platforms/52xx/motionpro.c contains code to  setup  some
custom   LEDs   on   this   board.   I   can't   find  that  code  in
arch/powerpc/platforms/mpc5200_simple.c.

It may be argued that this code should be moved somewhere else, but I
don't remeber to have seen any such review comments.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't have to stay up nights to succeed; you have to  stay  awake
days.
