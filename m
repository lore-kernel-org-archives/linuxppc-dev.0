Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
Date: Sat, 2 Dec 2006 21:00:19 +0100
References: <45708A0B.6000106@us.ibm.com>
In-Reply-To: <45708A0B.6000106@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612022100.20609.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 01 December 2006 21:01, Maynard Johnson wrote:
> +static void notify_spus_active(void)
> +{
> +       int node;
> +       for (node = 0; node < MAX_NUMNODES; node++) {
> +               struct spu *spu;
> +               mutex_lock(&spu_prio->active_mutex[node]);
> +               list_for_each_entry(spu, &spu_prio->active_list[node], list) {
> +                                struct spu_context *ctx = spu->ctx;
> +                                blocking_notifier_call_chain(&spu_switch_notifier,
> +                                                ctx ? ctx->object_id : 0, spu);
> +               }
> +               mutex_unlock(&spu_prio->active_mutex[node]);
> +        }

I wonder if this is enough for oprofile. Don't you need to access user
space data of the task running on the SPU? I always assumed you want
to do it via get_user or copy_from_user, which obviously doesn't work
here, when you're running in the oprofile task. Are you using something
like access_process_vm now?

	Arnd <><
