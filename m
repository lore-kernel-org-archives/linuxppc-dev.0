Return-Path: <robherring2@gmail.com>
Message-ID: <50532BB0.3090502@gmail.com>
Date: Fri, 14 Sep 2012 08:05:52 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 4/7] dt/powerpc/sysdev: Use of_get_child_by_name to
 get a named child.
References: <1347610764-20227-1-git-send-email-srinivas.kandagatla@st.com>
In-Reply-To: <1347610764-20227-1-git-send-email-srinivas.kandagatla@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2012 03:19 AM, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> As follow-up to "dt: introduce of_get_child_by_name to get child node by
> name." patch, This patch removes some of the code duplication in the
> driver by replacing it with of_get_child_by_name instead.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/powerpc/sysdev/qe_lib/qe.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
> index b043675..fd1c15d 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -568,10 +568,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
>  	}
>  
>  	/* Find the 'firmware' child node */
> -	for_each_child_of_node(qe, fw) {
> -		if (strcmp(fw->name, "firmware") == 0)
> -			break;
> -	}
> +	fw = of_get_child_by_name(qe "firmware");

Missing comma.

>  
>  	of_node_put(qe);
>  
> 
