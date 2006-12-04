Return-Path: <maynardj@us.ibm.com>
Message-ID: <45744079.40600@us.ibm.com>
Date: Mon, 04 Dec 2006 09:36:25 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
References: <45708A0B.6000106@us.ibm.com> <200612022100.20609.arnd@arndb.de>
In-Reply-To: <200612022100.20609.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 01 December 2006 21:01, Maynard Johnson wrote:
> 
>>+static void notify_spus_active(void)
>>+{
>>+       int node;
>>+       for (node = 0; node < MAX_NUMNODES; node++) {
>>+               struct spu *spu;
>>+               mutex_lock(&spu_prio->active_mutex[node]);
>>+               list_for_each_entry(spu, &spu_prio->active_list[node], list) {
>>+                                struct spu_context *ctx = spu->ctx;
>>+                                blocking_notifier_call_chain(&spu_switch_notifier,
>>+                                                ctx ? ctx->object_id : 0, spu);
>>+               }
>>+               mutex_unlock(&spu_prio->active_mutex[node]);
>>+        }
> 
> 
> I wonder if this is enough for oprofile. Don't you need to access user
> space data of the task running on the SPU? I always assumed you want
No, I don't need anything from the user app besides access to the 
executable binary, which I get with copy_from_user, specifying the 
'objectid' as from address.
> to do it via get_user or copy_from_user, which obviously doesn't work
> here, when you're running in the oprofile task. Are you using something
> like access_process_vm now?
> 
> 	Arnd <><
