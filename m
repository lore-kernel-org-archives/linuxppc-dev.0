Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200704122055.05048.arnd@arndb.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<20070412042337.GA21832@aepfle.de>
	<200704122043.38679.arnd@arndb.de>
	<200704122055.05048.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <117b47cdd5a232f9cb57f421e285558d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 3/3] cell: prevent alignment interrupt on
	local store
Date: Thu, 12 Apr 2007 21:57:45 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't know how many versions of libc you are currently building, but 
> it
> probably makes sense to have at least one that uses altivec, and one 
> for
> in-order (e.g. cell) and out-of-order (e.g. power5) pipelines each.

Something compiled for one in-order CPU will not run
very well on any other in-order CPU; each has specific
hazards (like any CPU core, but on in-order it tends
to _hurt_ if you hit any).

(Almost) all "generic" optimisations for in-order cores
(schedule dependent insns far apart, ...) help even
*more* on OoOE cores since those tend to be wider.

The big issue on the Cell PPU is that it simply cannot
execute half of the insns in the PowerPC architecture
at a reasonable speed.


Segher
