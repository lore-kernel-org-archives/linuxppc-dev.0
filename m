Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjhq1jkszDvyt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:22:34 +1100 (AEDT)
Date: Tue, 22 Nov 2016 16:12:28 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
cc: linux-kernel@vger.kernel.org
Subject: Locking API testsuite output mangled
Message-ID: <alpine.DEB.2.20.16.1611221606290.7542@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "Locking API testsuite" output during bootup (with 
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y) on this PowerPC system looks 
mangled, possibly related to the recent printk changes (4bcc595ccd80, 
"printk: reinstate KERN_CONT for printing continuation lines"). Before 
(e.g. with v4.6) it looked like this:

 http://nerdbynature.de/bits/4.6.0-rc7/dmesg.txt

See below for the current output.

Christian.

[    0.001417] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001439] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001453] ... MAX_LOCK_DEPTH:          48
[    0.001467] ... MAX_LOCKDEP_KEYS:        8191
[    0.001482] ... CLASSHASH_SIZE:          4096
[    0.001497] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001511] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001526] ... CHAINHASH_SIZE:          32768
[    0.001541]  memory used by lock dependency info: 5167 kB
[    0.001557]  per task-struct memory footprint: 1536 bytes
[    0.001574] ------------------------
[    0.001587] | Locking API testsuite:
[    0.001600] ----------------------------------------------------------------------------
[    0.001622]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.001644]   --------------------------------------------------------------------------
[    0.001681]                      A-A deadlock:
[    0.001705]   ok  |
[    0.003198]   ok  |
[    0.004555]   ok  |
[    0.005962]   ok  |
[    0.007307]   ok  |
[    0.008647]   ok  |

[    0.010015]                  A-B-B-A deadlock:
[    0.010045]   ok  |
[    0.011401]   ok  |
[    0.012736]   ok  |
[    0.014116]   ok  |
[    0.015458]   ok  |
[    0.016812]   ok  |

[    0.018175]              A-B-B-C-C-A deadlock:
[    0.018212]   ok  |
[    0.019575]   ok  |
[    0.020916]   ok  |
[    0.022304]   ok  |
[    0.023654]   ok  |
[    0.025017]   ok  |

[    0.026382]              A-B-C-A-B-C deadlock:
[    0.026419]   ok  |
[    0.027781]   ok  |
[    0.029122]   ok  |
[    0.030510]   ok  |
[    0.031860]   ok  |
[    0.033223]   ok  |

[    0.034587]          A-B-B-C-C-D-D-A deadlock:
[    0.034633]   ok  |
[    0.036007]   ok  |
[    0.037356]   ok  |
[    0.038757]   ok  |
[    0.040118]   ok  |
[    0.041492]   ok  |

[    0.042859]          A-B-C-D-B-D-D-A deadlock:
[    0.042905]   ok  |
[    0.044278]   ok  |
[    0.045628]   ok  |
[    0.047029]   ok  |
[    0.048388]   ok  |
[    0.049761]   ok  |

[    0.051130]          A-B-C-D-B-C-D-A deadlock:
[    0.051176]   ok  |
[    0.052551]   ok  |
[    0.053901]   ok  |
[    0.055303]   ok  |
[    0.056665]   ok  |
[    0.058040]   ok  |

[    0.059408]                     double unlock:
[    0.059429]   ok  |
[    0.060774]   ok  |
[    0.062103]   ok  |
[    0.063469]   ok  |
[    0.064800]   ok  |
[    0.066145]   ok  |

[    0.067508]                   initialize held:
[    0.067527]   ok  |
[    0.068870]   ok  |
[    0.070198]   ok  |
[    0.071561]   ok  |
[    0.072892]   ok  |
[    0.074235]   ok  |

[    0.075596]                  bad unlock order:
[    0.075623]   ok  |
[    0.076979]   ok  |
[    0.078316]   ok  |
[    0.079691]   ok  |
[    0.081031]   ok  |
[    0.082387]   ok  |

[    0.083753]   --------------------------------------------------------------------------
[    0.083791]               recursive read-lock:
[    0.083804]              |
[    0.083830]   ok  |
[    0.085157]              |
[    0.085183]   ok  |

[    0.086526]            recursive read-lock #2:
[    0.086539]              |
[    0.086564]   ok  |
[    0.087908]              |
[    0.087936]   ok  |

[    0.089280]             mixed read-write-lock:
[    0.089293]              |
[    0.089320]   ok  |
[    0.090643]              |
[    0.090672]   ok  |

[    0.092035]             mixed write-read-lock:
[    0.092048]              |
[    0.092075]   ok  |
[    0.093399]              |
[    0.093428]   ok  |

[    0.094771]   --------------------------------------------------------------------------
[    0.094809]      hard-irqs-on + irq-safe-A/12:
[    0.094829]   ok  |
[    0.096192]   ok  |
[    0.097523]   ok  |

[    0.098882]      soft-irqs-on + irq-safe-A/12:
[    0.098904]   ok  |
[    0.100270]   ok  |
[    0.101602]   ok  |

[    0.102962]      hard-irqs-on + irq-safe-A/21:
[    0.102982]   ok  |
[    0.104345]   ok  |
[    0.105678]   ok  |

[    0.107037]      soft-irqs-on + irq-safe-A/21:
[    0.107058]   ok  |
[    0.108422]   ok  |
[    0.109754]   ok  |

[    0.111112]        sirq-safe-A => hirqs-on/12:
[    0.111133]   ok  |
[    0.112498]   ok  |
[    0.113830]   ok  |

[    0.115189]        sirq-safe-A => hirqs-on/21:
[    0.115209]   ok  |
[    0.116574]   ok  |
[    0.117907]   ok  |

[    0.119266]          hard-safe-A + irqs-on/12:
[    0.119286]   ok  |
[    0.120649]   ok  |
[    0.121981]   ok  |

[    0.123341]          soft-safe-A + irqs-on/12:
[    0.123362]   ok  |
[    0.124727]   ok  |
[    0.126061]   ok  |

[    0.127420]          hard-safe-A + irqs-on/21:
[    0.127441]   ok  |
[    0.128806]   ok  |
[    0.130138]   ok  |

[    0.131498]          soft-safe-A + irqs-on/21:
[    0.131519]   ok  |
[    0.132884]   ok  |
[    0.134217]   ok  |

[    0.135575]     hard-safe-A + unsafe-B #1/123:
[    0.135604]   ok  |
[    0.136977]   ok  |
[    0.138316]   ok  |

[    0.139676]     soft-safe-A + unsafe-B #1/123:
[    0.139704]   ok  |
[    0.141079]   ok  |
[    0.142418]   ok  |

[    0.143779]     hard-safe-A + unsafe-B #1/132:
[    0.143807]   ok  |
[    0.145180]   ok  |
[    0.146520]   ok  |

[    0.147880]     soft-safe-A + unsafe-B #1/132:
[    0.147908]   ok  |
[    0.149282]   ok  |
[    0.150622]   ok  |

[    0.151983]     hard-safe-A + unsafe-B #1/213:
[    0.152011]   ok  |
[    0.153385]   ok  |
[    0.154725]   ok  |

[    0.156087]     soft-safe-A + unsafe-B #1/213:
[    0.156116]   ok  |
[    0.157490]   ok  |
[    0.158830]   ok  |

[    0.160190]     hard-safe-A + unsafe-B #1/231:
[    0.160215]   ok  |
[    0.161585]   ok  |
[    0.162925]   ok  |

[    0.164286]     soft-safe-A + unsafe-B #1/231:
[    0.164312]   ok  |
[    0.165683]   ok  |
[    0.167023]   ok  |

[    0.168384]     hard-safe-A + unsafe-B #1/312:
[    0.168403]   ok  |
[    0.169767]   ok  |
[    0.171106]   ok  |

[    0.172467]     soft-safe-A + unsafe-B #1/312:
[    0.172489]   ok  |
[    0.173854]   ok  |
[    0.175192]   ok  |

[    0.176554]     hard-safe-A + unsafe-B #1/321:
[    0.176578]   ok  |
[    0.177948]   ok  |
[    0.179288]   ok  |

[    0.180649]     soft-safe-A + unsafe-B #1/321:
[    0.180675]   ok  |
[    0.182047]   ok  |
[    0.183386]   ok  |

[    0.184747]     hard-safe-A + unsafe-B #2/123:
[    0.184775]   ok  |
[    0.186148]   ok  |
[    0.187486]   ok  |

[    0.188847]     soft-safe-A + unsafe-B #2/123:
[    0.188875]   ok  |
[    0.190249]   ok  |
[    0.191589]   ok  |

[    0.192950]     hard-safe-A + unsafe-B #2/132:
[    0.192976]   ok  |
[    0.194347]   ok  |
[    0.195685]   ok  |

[    0.197046]     soft-safe-A + unsafe-B #2/132:
[    0.197075]   ok  |
[    0.198450]   ok  |
[    0.199789]   ok  |

[    0.201150]     hard-safe-A + unsafe-B #2/213:
[    0.201176]   ok  |
[    0.202548]   ok  |
[    0.203886]   ok  |

[    0.205247]     soft-safe-A + unsafe-B #2/213:
[    0.205275]   ok  |
[    0.206650]   ok  |
[    0.207991]   ok  |

[    0.209353]     hard-safe-A + unsafe-B #2/231:
[    0.209378]   ok  |
[    0.210750]   ok  |
[    0.212088]   ok  |

[    0.213449]     soft-safe-A + unsafe-B #2/231:
[    0.213477]   ok  |
[    0.214850]   ok  |
[    0.216190]   ok  |

[    0.217553]     hard-safe-A + unsafe-B #2/312:
[    0.217579]   ok  |
[    0.218951]   ok  |
[    0.220289]   ok  |

[    0.221651]     soft-safe-A + unsafe-B #2/312:
[    0.221680]   ok  |
[    0.223054]   ok  |
[    0.224394]   ok  |

[    0.225755]     hard-safe-A + unsafe-B #2/321:
[    0.225781]   ok  |
[    0.227153]   ok  |
[    0.228491]   ok  |

[    0.229853]     soft-safe-A + unsafe-B #2/321:
[    0.229880]   ok  |
[    0.231253]   ok  |
[    0.232592]   ok  |

[    0.233954]       hard-irq lock-inversion/123:
[    0.233981]   ok  |
[    0.235356]   ok  |
[    0.236695]   ok  |

[    0.238057]       soft-irq lock-inversion/123:
[    0.238086]   ok  |
[    0.239462]   ok  |
[    0.240804]   ok  |

[    0.242167]       hard-irq lock-inversion/132:
[    0.242193]   ok  |
[    0.243565]   ok  |
[    0.244905]   ok  |

[    0.246267]       soft-irq lock-inversion/132:
[    0.246296]   ok  |
[    0.247672]   ok  |
[    0.249015]   ok  |

[    0.250378]       hard-irq lock-inversion/213:
[    0.250404]   ok  |
[    0.251779]   ok  |
[    0.253120]   ok  |

[    0.254482]       soft-irq lock-inversion/213:
[    0.254511]   ok  |
[    0.255887]   ok  |
[    0.257229]   ok  |

[    0.258591]       hard-irq lock-inversion/231:
[    0.258617]   ok  |
[    0.259989]   ok  |
[    0.261329]   ok  |

[    0.262690]       soft-irq lock-inversion/231:
[    0.262718]   ok  |
[    0.264092]   ok  |
[    0.265433]   ok  |

[    0.266795]       hard-irq lock-inversion/312:
[    0.266821]   ok  |
[    0.268194]   ok  |
[    0.269534]   ok  |

[    0.270896]       soft-irq lock-inversion/312:
[    0.270925]   ok  |
[    0.272300]   ok  |
[    0.273642]   ok  |

[    0.275005]       hard-irq lock-inversion/321:
[    0.275031]   ok  |
[    0.276403]   ok  |
[    0.277743]   ok  |

[    0.279105]       soft-irq lock-inversion/321:
[    0.279133]   ok  |
[    0.280507]   ok  |
[    0.281850]   ok  |

[    0.283212]       hard-irq read-recursion/123:
[    0.283237]   ok  |

[    0.284617]       soft-irq read-recursion/123:
[    0.284645]   ok  |

[    0.286006]       hard-irq read-recursion/132:
[    0.286031]   ok  |

[    0.287391]       soft-irq read-recursion/132:
[    0.287418]   ok  |

[    0.288799]       hard-irq read-recursion/213:
[    0.288825]   ok  |

[    0.290185]       soft-irq read-recursion/213:
[    0.290212]   ok  |

[    0.291571]       hard-irq read-recursion/231:
[    0.291596]   ok  |

[    0.292977]       soft-irq read-recursion/231:
[    0.293004]   ok  |

[    0.294364]       hard-irq read-recursion/312:
[    0.294389]   ok  |

[    0.295750]       soft-irq read-recursion/312:
[    0.295776]   ok  |

[    0.297156]       hard-irq read-recursion/321:
[    0.297182]   ok  |

[    0.298543]       soft-irq read-recursion/321:
[    0.298570]   ok  |

[    0.299931]   --------------------------------------------------------------------------
[    0.299969]   | Wound/wait tests |
[    0.299989]   ---------------------
[    0.300009]                   ww api failures:
[    0.300046]   ok  |
[    0.301439]   ok  |
[    0.302779]   ok  |

[    0.304139]                ww contexts mixing:
[    0.304160]   ok  |
[    0.305532]   ok  |

[    0.306881]              finishing ww context:
[    0.306901]   ok  |
[    0.308247]   ok  |
[    0.309606]   ok  |
[    0.310964]   ok  |

[    0.312311]                locking mismatches:
[    0.312330]   ok  |
[    0.313704]   ok  |
[    0.315046]   ok  |

[    0.316409]                  EDEADLK handling:
[    0.316442]   ok  |
[    0.317825]   ok  |
[    0.319174]   ok  |
[    0.320538]   ok  |
[    0.321903]   ok  |
[    0.323265]   ok  |
[    0.324610]   ok  |
[    0.325991]   ok  |
[    0.327338]   ok  |
[    0.328699]   ok  |

[    0.330066]            spinlock nest unlocked:
[    0.330086]   ok  |

[    0.331444]   -----------------------------------------------------
[    0.331470]                                  |block | try  |context|
[    0.331496]   -----------------------------------------------------
[    0.331522]                           context:
[    0.331551]   ok  |
[    0.332910]   ok  |
[    0.334275]   ok  |

[    0.335640]                               try:
[    0.335661]   ok  |
[    0.337007]   ok  |
[    0.338368]   ok  |

[    0.339732]                             block:
[    0.339752]   ok  |
[    0.341098]   ok  |
[    0.342458]   ok  |

[    0.343821]                          spinlock:
[    0.343852]   ok  |
[    0.345211]   ok  |
[    0.346586]   ok  |

[    0.347952] -------------------------------------------------------
[    0.347980] Good, all 253 testcases passed! |
[    0.348002] ---------------------------------
[    0.348051] pid_max: default: 32768 minimum: 301
-- 
BOFH excuse #441:

Hash table has woodworm
