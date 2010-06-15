Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 15 Jun 2010 10:33:51 -0600
Message-ID: <AANLkTimhAvu0_WuMCwnCrw9Rbcy6dKxvTlzepJm7ZDdR@mail.gmail.com>
Subject: Re: [PATCH 04/12] phylib: add a way to make PHY time stamps possible.
To: Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> This patch adds a new networking option to allow hardware time stamps
> from PHY devices. Using PHY time stamps will still require adding two
> inline function calls to each MAC driver. The CONFIG option makes these
> calls safe to add, since the calls become NOOPs when the option is
> disabled.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
> =A0include/linux/phy.h =A0 =A0| =A0 =A04 ++++
> =A0include/linux/skbuff.h | =A0 32 ++++++++++++++++++++++++++++++++
> =A0net/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +++++++++++
> =A03 files changed, 47 insertions(+), 0 deletions(-)
>
[...]
> diff --git a/net/Kconfig b/net/Kconfig
> index 0d68b40..3fa7ae3 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -86,6 +86,17 @@ config NETWORK_SECMARK
> =A0 =A0 =A0 =A0 =A0to nfmark, but designated for security purposes.
> =A0 =A0 =A0 =A0 =A0If you are unsure how to answer this question, answer =
N.
>
> +config NETWORK_PHY_TIMESTAMPING
> + =A0 =A0 =A0 bool "Timestamping in PHY devices"
> + =A0 =A0 =A0 depends on EXPERIMENTAL
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This allows timestamping of network packets by PHYs wit=
h
> + =A0 =A0 =A0 =A0 hardware timestamping capabilities. This option adds so=
me
> + =A0 =A0 =A0 =A0 overhead in the transmit and receive paths. Note that t=
his
> + =A0 =A0 =A0 =A0 option also requires support in the MAC driver.

Some overhead?  At a brief glance of the series it looks like it could
add a lot of overhead, but I'm not fully clear on what the full
process is.  Can you describe how the hardware timestamping works?  I
could use an overview of what the kernel has to do.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
