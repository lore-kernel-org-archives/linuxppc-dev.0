Return-Path: <sshtylyov@mvista.com>
Message-ID: <4D8C8F2B.9090808@ru.mvista.com>
Date: Fri, 25 Mar 2011 15:48:43 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH 5/5] xhci: Remove recursive call to xhci_handle_event
References: <4D8C47D8.4020901@ozlabs.org>
In-Reply-To: <4D8C47D8.4020901@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 25-03-2011 10:44, Matt Evans wrote:

> Make the caller loop while there are events to handle, instead.

> Signed-off-by: Matt Evans<matt@ozlabs.org>
> ---
>   drivers/usb/host/xhci-ring.c |   16 +++++++++-------
>   1 files changed, 9 insertions(+), 7 deletions(-)

> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index b46efd9..97bedd6 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
[...]
> @@ -2277,7 +2279,7 @@ hw_died:
>   	/* FIXME this should be a delayed service routine
>   	 * that clears the EHB.
>   	 */
> -	xhci_handle_event(xhci);
> +	while (xhci_handle_event(xhci)) {};

    Semicolon not needed after }. Perhaps the committer could change this...

WBR, Sergei
