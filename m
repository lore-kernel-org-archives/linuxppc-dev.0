From: Matthias Grimm <matthiasgrimm@users.sourceforge.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: [BUG] Problem in via-pmu.c, various kernel versions
Date: Sun, 8 Aug 2004 14:34:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408081434.50582.matthiasgrimm@users.sourceforge.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
The current pmu driver have a problem with detecting AC-Power.

The following code snippet shows that the battery states will only be updated
if TICK interrupts are received. The AC power flags will be taken from the
battery request answered by the PMU (see done_battery_state_ohare() and
done_battery_state_smart() ).

--- code snippet from via-pmu.c, kernel 2.6.7 ---

	/* Tick interrupt */
	else if ((1 << pirq) & PMU_INT_TICK) {
#ifdef CONFIG_PMAC_PBOOK
		/* Environement or tick interrupt, query batteries */
		if (pmu_battery_count) {
			if ((--query_batt_timer) == 0) {
				query_battery_state();
				query_batt_timer = BATTERY_POLLING_COUNT;
----

On my Powerbook G3 (Pismo) there won't be any TICK interrupts if it is running
on AC only (No batteries plugged in). Therefore neither the battery states
nor the AC power flags will be updated in this case.

This leads to incorrect power flags under following circumstances:
Machine runs on battery, put machine to sleep, connect AC plug, remove
battery, wakeup machine -> AC flag in /proc/pmu/info  still signals 'running
on battery'.

The same problem occur if the machine boots without batteries plugged in: the
AC flag is false.

My recommendations:
- update battery states independently from TICK or environment interrupts on a
regular time basis or
- distangle battery states and power flags. You could get the power flags also
with the PMU_GET_COVER request (only tested on PBG3 Pismo yet). Let the
battery states bounded to TICK interrupts but update the power flags on a
regular tiime basis.

  Best Regards
     Matthias

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
