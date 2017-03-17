Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl1Vl3XQKzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 21:17:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/pasemi,
 cbe: Do not process decremeter or external wakeup from powersave
In-Reply-To: <20170317174815.3e9686e2@roar.ozlabs.ibm.com>
References: <20170315154350.6256-1-npiggin@gmail.com>
 <874lytldgw.fsf@concordia.ellerman.id.au>
 <87r31wbfes.fsf@concordia.ellerman.id.au>
 <20170317174815.3e9686e2@roar.ozlabs.ibm.com>
Date: Fri, 17 Mar 2017 21:17:31 +1100
Message-ID: <874lyscimc.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 17 Mar 2017 17:12:11 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Nicholas Piggin <npiggin@gmail.com> writes:
>> >> I would like to start using a dedicated stack for system reset interrupt
>> >> and treat it as a Linux nmi, which makes it tricky to call complex
>> >> interrupt handlers directly from the system reset trap handler.
>> >>
>> >> So I would like to remove the decrementer and external handler calls from
>> >> Cell and Pasemi platforms' system reset handler. I think we can just
>> >> remove them if they can be handled when they re-fire as normal interrupts?
>> >> At the moment I don't have environments set up to test if this works.  
>> >
>> > My QS22 has booted OK with it applied, so it seems OK.
>> >
>> > I'll test it a bit more tomorrow.  
>> 
>> OK, seems fine, and I have a trace that shows it's definitely going
>> through that path:
>
> Thanks for testing it.
>
>>  1)               |    .default_idle_call() {
>>  1)               |      .arch_cpu_idle() {
>>  1)               |        .cbe_power_save() {
>>  1)   0.128 us    |          .prep_irq_for_idle();
>>  1)               |          .system_reset_exception() {
>>  1)   0.512 us    |            .cbe_system_reset_exception();
>>  1)   6.016 us    |          }
>>  1)               |          .do_IRQ() {
>
> It seems to do the right thing. I think decrementer should be working
> proprely by setting it to 1 to get another exception?

Yeah it is. It wasn't showing up in traces but I fixed that and here it
is below.

I'll try and test pasemi on Monday, but this looks fine for Cell.

cheers


 1)               |    .default_idle_call() {
 1)               |      .arch_cpu_idle() {
 1)               |        .cbe_power_save() {
 1)   0.192 us    |          .prep_irq_for_idle();
 1)               |          .system_reset_exception() {
 1)   0.320 us    |            .cbe_system_reset_exception();
 1)   6.016 us    |          }
 1)               |          .timer_interrupt() {
 1)               |            .irq_enter() {
 1)   0.768 us    |              .rcu_irq_enter();
 1)               |              .tick_irq_enter() {
 1)   0.256 us    |                .tick_check_oneshot_broadcast_this_cpu();
 1)               |                .ktime_get() {
 1)   0.192 us    |                  .timebase_read();
 1)   5.504 us    |                }
 1)               |                .update_ts_time_stats() {
 1)   0.640 us    |                  .nr_iowait_cpu();
 1)   6.656 us    |                }
 1) + 28.160 us   |              }
 1)               |              ._local_bh_enable() {
 1)   0.192 us    |                .__local_bh_enable();
 1)   5.120 us    |              }
 1)               |              .vtime_account_irq_enter() {
 1)               |                .vtime_account_idle() {
 1)   0.320 us    |                  .vtime_delta.isra.5();
 1)   5.504 us    |                }
 1) + 10.560 us   |              }
 1) + 66.048 us   |            }
 1)               |            .__timer_interrupt() {
 1)               |              .hrtimer_interrupt() {
 1)   0.448 us    |                ._raw_spin_lock();
 1)               |                .ktime_get_update_offsets_now() {
 1)   0.256 us    |                  .timebase_read();
 1)   5.760 us    |                }
 1)               |                .__hrtimer_run_queues() {
 1)   0.960 us    |                  .__remove_hrtimer();
 1)               |                  .tick_sched_timer() {
 1)               |                    .ktime_get() {
 1)   0.320 us    |                      .timebase_read();
 1)   5.888 us    |                    }
 1)               |                    .tick_sched_do_timer() {
 1)               |                      .tick_do_update_jiffies64.part.14() {
 1)   0.384 us    |                        ._raw_spin_lock();
 1)               |                        .do_timer() {
 1)   0.640 us    |                          .calc_global_load();
 1)   5.632 us    |                        }
 1)               |                        .update_wall_time() {
 1)   0.576 us    |                          ._raw_spin_lock_irqsave();
 1)   0.192 us    |                          .timebase_read();
 1)   0.192 us    |                          .ntp_tick_length();
 1)   0.256 us    |                          .ntp_tick_length();
 1)   0.192 us    |                          .ntp_tick_length();
 1)               |                          .timekeeping_update() {
 1)   0.192 us    |                            .ntp_get_next_leap();
 1)   1.600 us    |                            .update_vsyscall_old();
 1)               |                            .raw_notifier_call_chain() {
 1)   0.768 us    |                              .notifier_call_chain();
 1)   5.760 us    |                            }
 1)   0.768 us    |                            .update_fast_timekeeper();
 1)   0.384 us    |                            .update_fast_timekeeper();
 1) + 34.304 us   |                          }
 1)   0.192 us    |                          ._raw_spin_unlock_irqrestore();
 1) + 75.264 us   |                        }
 1) + 98.048 us   |                      }
 1) ! 103.552 us  |                    }
 1)               |                    .tick_sched_handle.isra.16() {
 1)               |                      .update_process_times() {
 1)               |                        .vtime_flush() {
 1)   0.576 us    |                          .account_idle_time();
 1)   5.952 us    |                        }
 1)               |                        .run_local_timers() {
 1)   0.192 us    |                          .hrtimer_run_queues();
 1)               |                          .raise_softirq() {
 1)   0.704 us    |                            .__raise_softirq_irqoff();
 1)   5.440 us    |                          }
 1) + 16.128 us   |                        }
 1)               |                        .rcu_check_callbacks() {
 1)   0.256 us    |                          .rcu_sched_qs();
 1)   0.256 us    |                          .cpu_needs_another_gp();
 1)   0.192 us    |                          .cpu_needs_another_gp();
 1) + 17.536 us   |                        }
 1)               |                        .scheduler_tick() {
 1)   0.448 us    |                          ._raw_spin_lock();
 1)   0.640 us    |                          .update_rq_clock();
 1)   0.192 us    |                          .task_tick_idle();
 1)               |                          .cpu_load_update_active() {
 1)   0.576 us    |                            .tick_nohz_tick_stopped();
 1)               |                            .cpu_load_update() {
 1)   0.192 us    |                              .decay_load_missed();
 1)   0.256 us    |                              .decay_load_missed();
 1)   0.192 us    |                              .decay_load_missed();
 1)   0.192 us    |                              .decay_load_missed();
 1)   0.256 us    |                              .decay_load_missed();
 1)   0.192 us    |                              .decay_load_missed();
 1)   0.128 us    |                              .decay_load_missed();
 1)   0.576 us    |                              .decay_load_missed();
 1)   0.448 us    |                              .sched_avg_update();
 1) + 46.592 us   |                            }
 1) + 57.088 us   |                          }
 1)   0.256 us    |                          .calc_global_load_tick();
 1)               |                          .trigger_load_balance() {
 1)               |                            .raise_softirq() {
 1)   0.256 us    |                              .__raise_softirq_irqoff();
 1)   5.504 us    |                            }
 1) + 10.496 us   |                          }
 1) + 99.456 us   |                        }
 1)   0.896 us    |                        .run_posix_cpu_timers();
 1) ! 165.504 us  |                      }
 1)   0.256 us    |                      .profile_tick();
 1) ! 175.744 us  |                    }
 1)               |                    .hrtimer_forward() {
 1)   0.192 us    |                      .ktime_add_safe();
 1)   0.192 us    |                      .ktime_add_safe();
 1) + 10.880 us   |                    }
 1) ! 315.968 us  |                  }
 1)   0.320 us    |                  ._raw_spin_lock();
 1)   0.704 us    |                  .enqueue_hrtimer();
 1) ! 339.072 us  |                }
 1)   0.256 us    |                .__hrtimer_get_next_event();
 1)               |                .tick_program_event() {
 1)               |                  .clockevents_program_event() {
 1)               |                    .ktime_get() {
 1)   0.192 us    |                      .timebase_read();
 1)   5.568 us    |                    }
 1)   0.192 us    |                    .decrementer_set_next_event();
 1) + 16.448 us   |                  }
 1) + 21.888 us   |                }
 1) ! 393.152 us  |              }
 1) ! 398.592 us  |            }
 1)               |            .irq_exit() {
 1)               |              .vtime_account_system() {
 1)   0.320 us    |                .vtime_delta.isra.5();
 1)   5.760 us    |              }
 1)               |              .__do_softirq() {
 1)               |                .vtime_account_irq_enter() {
 1)               |                  .vtime_account_idle() {
 1)   0.256 us    |                    .vtime_delta.isra.5();
 1)   5.632 us    |                  }
 1) + 10.944 us   |                }
 1)               |                .run_timer_softirq() {
 1)   0.896 us    |                  ._raw_spin_lock_irq();
 1)   0.640 us    |                  .collect_expired_timers();
 1)   0.320 us    |                  ._raw_spin_lock_irq();
 1)   0.256 us    |                  .collect_expired_timers();
 1) + 23.552 us   |                }
 1)               |                .run_rebalance_domains() {
 1)               |                  .rebalance_domains() {
 1)   0.256 us    |                    ._raw_spin_lock_irqsave();
 1)   0.320 us    |                    .update_rq_clock();
 1)   0.256 us    |                    .__compute_runnable_contrib();
 1)   0.256 us    |                    ._raw_spin_unlock_irqrestore();
 1)   0.384 us    |                    .__msecs_to_jiffies();
 1)               |                    .load_balance() {
 1)   0.320 us    |                      .idle_cpu();
 1)               |                      .find_busiest_group() {
 1)               |                        .update_group_capacity() {
 1)   0.448 us    |                          .__msecs_to_jiffies();
 1)   6.016 us    |                        }
 1)   0.576 us    |                        .idle_cpu();
 1) + 18.624 us   |                      }
 1) + 31.680 us   |                    }
 1)   0.192 us    |                    .__msecs_to_jiffies();
 1)   0.128 us    |                    .__msecs_to_jiffies();
 1)   0.576 us    |                    ._raw_spin_trylock();
 1)               |                    .load_balance() {
 1)   0.256 us    |                      .idle_cpu();
 1)   0.192 us    |                      .idle_cpu();
 1)               |                      .find_busiest_group() {
 1)               |                        .update_group_capacity() {
 1)   0.192 us    |                          .__msecs_to_jiffies();
 1)   5.632 us    |                        }
 1)   0.256 us    |                        .idle_cpu();
 1)   0.576 us    |                        .idle_cpu();
 1)   0.768 us    |                        .idle_cpu();
 1) + 31.808 us   |                      }
 1) + 47.872 us   |                    }
 1)   0.128 us    |                    .__msecs_to_jiffies();
 1) ! 141.504 us  |                  }
 1) ! 147.328 us  |                }
 1)   0.320 us    |                .rcu_bh_qs();
 1)               |                .vtime_account_system() {
 1)   0.320 us    |                  .vtime_delta.isra.5();
 1)   5.568 us    |                }
 1)   0.192 us    |                .__local_bh_enable();
 1) ! 220.416 us  |              }
 1)   0.832 us    |              .idle_cpu();
 1)               |              .tick_nohz_irq_exit() {
 1)               |                .__tick_nohz_idle_enter() {
 1)               |                  .ktime_get() {
 1)   0.576 us    |                    .timebase_read();
 1)   5.568 us    |                  }
 1)   0.256 us    |                  .rcu_needs_cpu();
 1)   0.192 us    |                  .timer_clear_idle();
 1) + 21.696 us   |                }
 1) + 27.520 us   |              }
 1)               |              .rcu_irq_exit() {
 1)   1.024 us    |                .rcu_eqs_enter_common.isra.46();
 1)   6.400 us    |              }
 1) ! 285.504 us  |            }
 1) ! 765.248 us  |          }
 1) # 2864.576 us |        }
 1) # 2871.616 us |      }
 1) # 2877.184 us |    }
