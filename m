Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkw3b43ktzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 17:12:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pasemi,
 cbe: Do not process decremeter or external wakeup from powersave
In-Reply-To: <874lytldgw.fsf@concordia.ellerman.id.au>
References: <20170315154350.6256-1-npiggin@gmail.com>
 <874lytldgw.fsf@concordia.ellerman.id.au>
Date: Fri, 17 Mar 2017 17:12:11 +1100
Message-ID: <87r31wbfes.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> Hi,
>>
>> I would like to start using a dedicated stack for system reset interrupt
>> and treat it as a Linux nmi, which makes it tricky to call complex
>> interrupt handlers directly from the system reset trap handler.
>>
>> So I would like to remove the decrementer and external handler calls from
>> Cell and Pasemi platforms' system reset handler. I think we can just
>> remove them if they can be handled when they re-fire as normal interrupts?
>> At the moment I don't have environments set up to test if this works.
>
> My QS22 has booted OK with it applied, so it seems OK.
>
> I'll test it a bit more tomorrow.

OK, seems fine, and I have a trace that shows it's definitely going
through that path:


 1)               |    .default_idle_call() {
 1)               |      .arch_cpu_idle() {
 1)               |        .cbe_power_save() {
 1)   0.128 us    |          .prep_irq_for_idle();
 1)               |          .system_reset_exception() {
 1)   0.512 us    |            .cbe_system_reset_exception();
 1)   6.016 us    |          }
 1)               |          .do_IRQ() {
 1)               |            .__do_irq() {
 1)               |              .irq_enter() {
 1)   0.704 us    |                .rcu_irq_enter();
 1)               |                .tick_irq_enter() {
 1)   0.448 us    |                  .tick_check_oneshot_broadcast_this_cpu();
 1)   0.768 us    |                  .ktime_get();
 1)               |                  .update_ts_time_stats() {
 1)   0.256 us    |                    .nr_iowait_cpu();
 1)   5.632 us    |                  }
 1)   0.192 us    |                  .touch_softlockup_watchdog_sched();
 1) + 27.904 us   |                }
 1)               |                ._local_bh_enable() {
 1)   0.320 us    |                  .__local_bh_enable();
 1)   5.760 us    |                }
 1)   1.024 us    |                .vtime_account_irq_enter();
 1) + 55.744 us   |              }
 1)   1.024 us    |              .iic_get_irq();
 1)               |              .generic_handle_irq() {
 1)               |                .handle_percpu_irq() {
 1)               |                  .handle_irq_event_percpu() {
 1)               |                    .__handle_irq_event_percpu() {
 1)               |                      .reschedule_action() {
 1)               |                        .scheduler_ipi() {
 1)               |                          .irq_enter() {
 1)   0.640 us    |                            .rcu_irq_enter();
 1)   0.384 us    |                            .vtime_account_irq_enter();
 1) + 11.776 us   |                          }
 1)               |                          .sched_ttwu_pending() {
 1)   0.448 us    |                            ._raw_spin_lock_irqsave();
 1)               |                            .ttwu_do_activate() {
 1)               |                              .activate_task() {
 1)   0.256 us    |                                .update_rq_clock();
 1)               |                                .enqueue_task_fair() {
 1)   0.320 us    |                                  .update_curr();
 1)   0.256 us    |                                  .__compute_runnable_contrib();
 1)   0.384 us    |                                  .attach_entity_load_avg();
 1)   0.256 us    |                                  .__enqueue_entity();
 1)   0.192 us    |                                  .hrtick_update();
 1) + 30.592 us   |                                }
 1) + 41.216 us   |                              }
 1)               |                              .wq_worker_waking_up() {
 1)   0.576 us    |                                .kthread_data();
 1)   6.464 us    |                              }
 1)               |                              .ttwu_do_wakeup() {
 1)               |                                .check_preempt_curr() {
 1)   0.576 us    |                                  .resched_curr();
 1)   6.272 us    |                                }
 1) + 12.224 us   |                              }
 1) + 75.904 us   |                            }
 1)   0.320 us    |                            ._raw_spin_unlock_irqrestore();
 1) + 92.736 us   |                          }
 1)               |                          .irq_exit() {
 1)   0.192 us    |                            .idle_cpu();
 1)   0.256 us    |                            .rcu_irq_exit();
 1) + 11.520 us   |                          }
 1) ! 132.032 us  |                        }
 1) ! 137.280 us  |                      }
 1) ! 142.784 us  |                    }
 1)               |                    .add_interrupt_randomness() {
 1)   0.704 us    |                      ._raw_spin_trylock();
 1)               |                      .__mix_pool_bytes() {
 1)   1.152 us    |                        ._mix_pool_bytes();
 1)   6.464 us    |                      }
 1)               |                      .credit_entropy_bits() {
 1)               |                        .__wake_up() {
 1)   0.384 us    |                          ._raw_spin_lock_irqsave();
 1)   0.256 us    |                          .__wake_up_common();
 1)   0.256 us    |                          ._raw_spin_unlock_irqrestore();
 1) + 16.384 us   |                        }
 1)   0.256 us    |                        .kill_fasync();
 1) + 27.584 us   |                      }
 1) + 49.856 us   |                    }
 1)   0.256 us    |                    .note_interrupt();
 1) ! 208.768 us  |                  }
 1)   0.448 us    |                  .iic_eoi();
 1) ! 220.352 us  |                }
 1) ! 227.200 us  |              }
 1)               |              .irq_exit() {
 1)   0.128 us    |                .idle_cpu();
 1)               |                .rcu_irq_exit() {
 1)   0.576 us    |                  .rcu_eqs_enter_common.isra.46();
 1)   3.840 us    |                }
 1) + 10.688 us   |              }
 1) ! 313.024 us  |            }
 1) ! 318.400 us  |          }
 1) @ 960000.6 us |        }
 1) @ 960004.3 us |      }
 1) @ 960007.8 us |    }

cheers
